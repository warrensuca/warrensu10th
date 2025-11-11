import urllib.request
from PIL import Image

from nba_api.stats.static import players
from nba_api.stats.endpoints import playercareerstats

from nba_api.stats.endpoints import leaguedashplayerstats
from nba_api.stats.endpoints import boxscoreadvancedv2

import json
import numpy as np
from collections import defaultdict
def fetchAllPlayerIDs():
    ids = []
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])
   #print("Number of players fetched: {}".format(len(nba_players)))
    return ids
    

    
class Player:
    def __init__(self, id):
        self.id = id
        self.playerstats = playercareerstats.PlayerCareerStats(player_id=id)
        self.regularSeasons = self.playerstats.get_normalized_dict()['SeasonTotalsRegularSeason'][0]
        self.totals = self.playerstats.get_normalized_dict()['CareerTotalsRegularSeason'][0]


    def getName(self):
        nba_players = players.get_active_players()
        for i in range(len(nba_players)):
            if nba_players[i]['id'] == int(self.id):
                return nba_players[i]['full_name']
        
        
    
    def getImageURL(self):
        return "https://cdn.nba.com/headshots/nba/latest/1040x760/{}.png".format(self.id)

    def getPPG(self):
        
        return (self.totals['PTS']/self.totals['GP']) 
        
    def getRPG(self):
        return (self.totals['REB']/self.totals['GP'])
    
    def getAST(self):
        return (self.totals['AST']/self.totals['GP'])
    
    def getSTL(self):
        
        return (self.totals['STL']/self.totals['GP'])
    
    def getBLK(self):
        
        return (self.totals['BLK']/self.totals['GP'])

    def getPCT(self):
        return (self.totals['FG_PCT'])
    
    def get3PCT(self):
        return (self.totals['FG3_PCT'])
    
davis = Player("203076")

print(davis.getName())
print(davis.getPPG())
print(davis.getSTL())

def getDictofPlayerStats():
    output = []
    ids_set = set(fetchAllPlayerIDs())
    statsSeason = leaguedashplayerstats.LeagueDashPlayerStats(season='2024-25')
    teamAbbreviations = set([
            "ATL", "BOS", "BKN", "CHA", "CHI", "CLE", "DAL", "DEN", 
            "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", 
            "MIL", "MIN", "NOP", "NYK", "OKC", "ORL", "PHI", "PHX", 
            "POR", "SAC", "SAS", "TOR", "UTA", "WAS"
        ])#filter out gleague guys
    
    playerRepeatCount = defaultdict(int)
    tempDict = {}
    #print(statsSeason.get_normalized_dict()["LeagueDashPlayerStats"][:2])

    for playerProfile in statsSeason.get_normalized_dict()["LeagueDashPlayerStats"]:
        
        if (playerProfile['PLAYER_NAME'] != None and playerProfile['PLAYER_ID'] in ids_set and playerProfile['GP'] > 0
        and playerProfile['TEAM_ABBREVIATION'] in teamAbbreviations):
            playerRepeatCount[playerProfile['PLAYER_ID']] += 1
            if playerRepeatCount[playerProfile['PLAYER_ID']] == 1:
                
                tempDict[playerProfile['PLAYER_ID']] = [
                playerProfile['PTS'],
                playerProfile['REB'],
                playerProfile['AST'],
                playerProfile['STL'],
                playerProfile['BLK'],
                playerProfile['GP']]
            else:
                
                
                tempDict[playerProfile['PLAYER_ID']][0] += playerProfile['PTS']
                

                tempDict[playerProfile['PLAYER_ID']][1] += playerProfile['REB']
                

                tempDict[playerProfile['PLAYER_ID']][2] += playerProfile['AST']
                

                tempDict[playerProfile['PLAYER_ID']][3] += playerProfile['STL']
                

                tempDict[playerProfile['PLAYER_ID']][4] += playerProfile['BLK']

                tempDict[playerProfile['PLAYER_ID']][5] += playerProfile['GP']
    
    
    return tempDict
#print(getDictofPlayerStats())
#print(getDictofPlayerStats()[2544])
def getProccesableJson():
    output = []
    ids_set = set(fetchAllPlayerIDs())
    statsSeason = leaguedashplayerstats.LeagueDashPlayerStats(season='2024-25')
    teamAbbreviations = set([
            "ATL", "BOS", "BKN", "CHA", "CHI", "CLE", "DAL", "DEN", 
            "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", 
            "MIL", "MIN", "NOP", "NYK", "OKC", "ORL", "PHI", "PHX", 
            "POR", "SAC", "SAS", "TOR", "UTA", "WAS"
        ])#filter out gleague guys
    statsDict = getDictofPlayerStats()
    coveredPlayers = set()
    for playerProfile in statsSeason.get_normalized_dict()["LeagueDashPlayerStats"]:

        if (playerProfile['PLAYER_NAME'] != None and playerProfile['PLAYER_ID'] in ids_set and playerProfile['GP'] > 0
            and playerProfile['TEAM_ABBREVIATION'] in teamAbbreviations and playerProfile['PLAYER_ID'] not in coveredPlayers):
            
            player_data = {
                "id": playerProfile['PLAYER_ID'],
                "name": playerProfile['PLAYER_NAME'],
                "imageURL": "https://cdn.nba.com/headshots/nba/latest/1040x760/{}.png".format(playerProfile['PLAYER_ID']),
                "PPG": round(statsDict[playerProfile['PLAYER_ID']][0]/statsDict[playerProfile['PLAYER_ID']][5],1),
                "RPG": round(statsDict[playerProfile['PLAYER_ID']][1]/statsDict[playerProfile['PLAYER_ID']][5],1),
                "AST": round(statsDict[playerProfile['PLAYER_ID']][2]/statsDict[playerProfile['PLAYER_ID']][5],1),
                "STL": round(statsDict[playerProfile['PLAYER_ID']][3]/statsDict[playerProfile['PLAYER_ID']][5],1),
                "BLK": round(statsDict[playerProfile['PLAYER_ID']][4]/statsDict[playerProfile['PLAYER_ID']][5],1),
                "FG%": playerProfile['FG_PCT'],
                "3P%": playerProfile['FG3_PCT'],
            }
            
            output.append(player_data)
            coveredPlayers.add(playerProfile['PLAYER_ID'])
    
    with open("BasicStatsJsonFile.json", "w") as json_file:
        json.dump(output, json_file, indent=4)
    return json.dumps(output, indent = 2)


def downloadImage(id):
    url = "https://cdn.nba.com/headshots/nba/latest/1040x760/{}.png".format(id)
    urllib.request.urlretrieve(url, "{}.png".format(id))

def downloadAllPlayerImages():
    statsSeason = leaguedashplayerstats.LeagueDashPlayerStats(season='2024-25')
    coveredPlayers = set()
    ids_set = set(fetchAllPlayerIDs())

    teamAbbreviations = set([
            "ATL", "BOS", "BKN", "CHA", "CHI", "CLE", "DAL", "DEN", 
            "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", 
            "MIL", "MIN", "NOP", "NYK", "OKC", "ORL", "PHI", "PHX", 
            "POR", "SAC", "SAS", "TOR", "UTA", "WAS"
        ])
    
    for playerProfile in statsSeason.get_normalized_dict()["LeagueDashPlayerStats"]:

        if (playerProfile['PLAYER_NAME'] != None and playerProfile['PLAYER_ID'] in ids_set and playerProfile['GP'] > 0
            and playerProfile['TEAM_ABBREVIATION'] in teamAbbreviations and playerProfile['PLAYER_ID'] not in coveredPlayers):
            downloadImage(playerProfile['PLAYER_ID'])



def getPlayerAverages():
    statsData = json.load(open("BasicStatsJsonFile.json"))

    

    statsDict = {player["id"]: {
                        "name": player["name"],
                        "PPG": player["PPG"],
                        "RPG": player["RPG"],
                        "AST": player["AST"],
                        "STL": player["STL"],
                        "BLK": player["BLK"],
                        "FG%": player["FG%"],
                        "3P%": player["3P%"]
                    } 
                for player in statsData}
    shotData = json.load(open("ShotData.json"))
    playerKeys = statsDict.keys()
    for id in statsDict.keys():
        id_int = int(id)
        if str(id_int) in shotData and len(shotData[str(id_int)]) > 2:
            statsDict[id_int]["%2Shots"] = round(shotData[str(id_int)][2], 1) / 100
        else:
            
            statsDict[id_int]["%2Shots"] = 0

    return statsDict

def combineJsonFiles():
    data = getPlayerAverages()
    with open("fullStats.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
    return json.dumps(data, indent = 2)
#combineJsonFiles()


def getLeagueAverages():
    statsDict = getPlayerAverages()
    out = {"PPG": 0, "RPG": 0, "AST": 0, "STL": 0, "BLK": 0, "FG%": 0 , "3P%": 0, "%2Shots": 0}
    outKeys = list(out.keys())
    temp = [[player.get(k, 0) for k in outKeys] for player in statsDict.values()]
    statsArr = np.array(temp, dtype=float)  

    stats = np.mean(statsArr, axis=0) 
    

    for i, key in enumerate(outKeys):
        out[key] = round(float(stats[i]), 2)  

    return out
    
#print(getLeagueAverages())
def getSTD():
    statsDict = getPlayerAverages()
    out = {"PPG": 0, "RPG": 0, "AST": 0, "STL": 0, "BLK": 0, "FG%": 0 , "3P%": 0, "%2Shots": 0}
    outKeys = list(out.keys())

    temp = [[player.get(k, 0) for k in outKeys] for player in statsDict.values()]
    statsArr = np.array(temp, dtype=float)  

    # compute std for each stat (axis=0 = across players)
    stds = np.std(statsArr, axis=0)

    for i, key in enumerate(outKeys):
        out[key] = round(float(stds[i]), 2)

    return out



def getPlayerScaledStats(id):
    statsDict = getPlayerAverages()
    
    leagueAverages = list(getLeagueAverages().values())
    std = list(getSTD().values())
    out = {"PPG": 0, "RPG": 0, "AST": 0, "STL": 0, "BLK": 0, "FG%": 0 , "3P%": 0, "%2Shots": 0}
    statKeys = out.keys()
    stats = [statsDict[id].get(k, 0) for k in statKeys]
    #print(stats)
    scaledStats = []
    for i in range(len(stats)):
        scaledStats.append((stats[i]-leagueAverages[i])/std[i])
    
    return scaledStats

def getDictPlayerScaledStats(id):
    statsDict = getPlayerAverages()
    
    leagueAverages = list(getLeagueAverages().values())
    std = list(getSTD().values())
    out = {"PPG": 0, "RPG": 0, "AST": 0, "STL": 0, "BLK": 0, "FG%": 0 , "3P%": 0, "%2Shots": 0}
    statKeys = list(out.keys())
    stats = [statsDict[id].get(k, 0) for k in statKeys]
    #print(stats)
   
    for i in range(0,len(statKeys)):
        out[statKeys[i]] = ((stats[i]-leagueAverages[i])/std[i])
    
    return out

print(getPlayerScaledStats(2544))
print(getDictPlayerScaledStats(2544))
def getPlayerScaledStatsJson():

    full_averages = getPlayerAverages()
    
    ids = getPlayerAverages().keys()
    data = {}
    
    for id in ids:
        data[id] = {}
        data[id]['name'] = full_averages[id]['name']
        data[id].update(getDictPlayerScaledStats(id))
        
    with open("STD_scaled_stats.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
    return json.dumps(data, indent = 2)

getPlayerScaledStatsJson()

def format2_averages_json() :
    
    player_stats = getPlayerAverages()
    
    data = []
   
    

    for id, stats in player_stats.items():
        player_data = {"id": int(id), "name": stats["name"]}
        player_data.update(player_stats[id])
        data.append(player_data)

    with open("stats_2.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
#format2_averages_json()

def format2_std_json() :
    
    full_averages = getPlayerAverages()
    data = []

    for id, stats in full_averages.items():
        player_data = {"id": int(id), "name": stats["name"]}
        player_data.update(getDictPlayerScaledStats(id))
        data.append(player_data)
    
    with open("STD_scaled_stats_2.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
#format2_std_json()

def getSimilarity(id1, id2):
    #vector projection cosine similarity
    statsDict = getPlayerAverages()
    
    player1 = np.array(getPlayerScaledStats(id1))
    player2 = np.array(getPlayerScaledStats(id2))
    
    vProjectionSimilarity = np.dot(player1, player2)/(np.linalg.norm(player1)*np.linalg.norm(player2))

    #euclidean distance 

    euclideanSimilarity = 1 / (1 + np.linalg.norm(player1 - player2))


    return 0.8 * vProjectionSimilarity + 0.2 * euclideanSimilarity #arbitrary scale, trial and error
print('\n')
print(getSimilarity(2544, 1631094)) #lebron with banchero, many people say banchero is the most similar to lebron
print(getSimilarity(203954, 201939)) #embied with curry, pretty different players
print(getSimilarity(2544, 1629029)) #lebron with luka, pretty simillar players

print(getSimilarity(203497, 1629027)) #gobert with trae young


