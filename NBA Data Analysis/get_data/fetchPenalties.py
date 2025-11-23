import json
import numpy as np
from collections import defaultdict
from nba_api.stats.endpoints import leaguedashplayerstats
from nba_api.stats.static import players

def fetchAllPlayerIDs():
    nba_players = players.get_active_players()
    return [p['id'] for p in nba_players]


def getPenaltyAverages():
    ids_set = set(fetchAllPlayerIDs())
    statsSeason = leaguedashplayerstats.LeagueDashPlayerStats(season='2024-25')

    penalties = {}
    playerRepeatCount = defaultdict(int)

    for p in statsSeason.get_normalized_dict()["LeagueDashPlayerStats"]:
        pid = p["PLAYER_ID"]

        # only real nba players with games played
        if pid in ids_set and p["GP"] > 0:
            playerRepeatCount[pid] += 1

            if playerRepeatCount[pid] == 1:
                penalties[pid] = {
                    "PF": p["PF"],
                    "TOV": p["TOV"],
                    "GP": p["GP"]
                }
            else:
                penalties[pid]["PF"] += p["PF"]
                penalties[pid]["TOV"] += p["TOV"]
                penalties[pid]["GP"] += p["GP"]

    # Convert totals → averages
    out = {}
    for pid, vals in penalties.items():
        out[str(pid)] = {
            "PF": round(vals["PF"] / vals["GP"], 3),
            "TOV": round(vals["TOV"] / vals["GP"], 3)
        }

    with open("data/PenaltyAverages.json", "w") as f:
        json.dump(out, f, indent=4)

    return out



def getPenaltyZScores():
    penalties = json.load(open("data/PenaltyAverages.json"))

    PF_vals = [p["PF"] for p in penalties.values()]
    TOV_vals = [p["TOV"] for p in penalties.values()]

    PF_mean = np.mean(PF_vals)
    PF_std = np.std(PF_vals)
    TOV_mean = np.mean(TOV_vals)
    TOV_std = np.std(TOV_vals)

    out = {}
    for pid, vals in penalties.items():
        out[pid] = {
            "PF_z": (vals["PF"] - PF_mean) / PF_std,
            "TOV_z": (vals["TOV"] - TOV_mean) / TOV_std
        }

    with open("data/PenaltyZScores.json", "w") as f:
        json.dump(out, f, indent=4)

    return out


def mergePenaltyAveragesIntoStatsFull():
    full = json.load(open("data/stats_full.json"))
    penalties = json.load(open("data/PenaltyAverages.json"))

    out = []
    for p in full:
        pid = str(p["id"])
        if pid in penalties:
            p["PF"] = penalties[pid]["PF"]
            p["TOV"] = penalties[pid]["TOV"]
        else:
            p["PF"] = 0
            p["TOV"] = 0
        out.append(p)

    with open("data/most_recent/stats_full.json", "w") as f:
        json.dump(out, f, indent=4)

    return out


def mergePenaltyZIntoStatsFullStd():
    full = json.load(open("data/scaled_stats_full.json"))
    penalties = json.load(open("data/PenaltyZScores.json"))

    out = []
    for p in full:
        pid = str(p["id"])
        if pid in penalties:
            p["PF_z"] = penalties[pid]["PF_z"]
            p["TOV_z"] = penalties[pid]["TOV_z"]
        else:
            p["PF_z"] = 0
            p["TOV_z"] = 0
        out.append(p)

    with open("data/most_recent/scaled_stats_full.json", "w") as f:
        json.dump(out, f, indent=4)

    return out



def buildPenaltyPipeline():
    print("Step 1: Fetching PF/TOV averages...")
    getPenaltyAverages()

    print("Step 2: Building penalty z-scores...")
    getPenaltyZScores()

    print("Step 3: Updating stats_full.json...")
    mergePenaltyAveragesIntoStatsFull()

    print("➡ Step 4: Updating scaled_stats_full.json...")
    mergePenaltyZIntoStatsFullStd()

    print("✔ Penalty pipeline complete.")



buildPenaltyPipeline()
