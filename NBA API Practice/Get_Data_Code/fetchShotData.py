from nba_api.stats.static import players
from nba_api.stats.endpoints import shotchartdetail
import json
from collections import defaultdict
import time
def fetchAllPlayerIDs():
    ids = []
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])
   #print("Number of players fetched: {}".format(len(nba_players)))
    return ids
    

def fetchShotData():
    ids = fetchAllPlayerIDs()
    ids_set = set()

    shotDict = defaultdict(list)
    for id in ids:
        try:
            time.sleep(1)
            if id in ids_set:
                continue
            shot_chart = shotchartdetail.ShotChartDetail(
                team_id=0,  # 0 = individual player
                player_id=id,
                season_nullable ='2024-25',
                season_type_all_star='Regular Season'
            )
            shots = shot_chart.get_data_frames()[0] 

            
            total_shots = len(shots)
            three_pt_shots = len(shots[shots['SHOT_TYPE'] == '3PT Field Goal'])
            two_pt_shots = len(shots[shots['SHOT_TYPE'] == '2PT Field Goal'])

            if total_shots == 0:
                continue
            
            pct_3pt = three_pt_shots / total_shots * 100
            pct_2pt = two_pt_shots / total_shots * 100
            print(id)
            print([two_pt_shots, three_pt_shots, pct_2pt, pct_3pt])
            shotDict[id] = [two_pt_shots, three_pt_shots, pct_2pt, pct_3pt]
            ids_set.add(id)
        except Exception as e:
            print(f"Skipping player {id} due to error: {e}")
            continue
    return shotDict

def getShotJson():
    data = fetchShotData()
    with open("ShotData.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
    return json.dumps(data, indent = 2)

getShotJson()