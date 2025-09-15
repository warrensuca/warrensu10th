
from nba_api.stats.static import players
from nba_api.stats.endpoints import playercareerstats

from nba_api.stats.endpoints import leaguedashplayerstats
from nba_api.stats.endpoints import boxscoreadvancedv2

import json
from collections import defaultdict
def fetchAllPlayerIDs():
    ids = []
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])
    print("Number of players fetched: {}".format(len(nba_players)))
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
    
    coveredPlayers = set()
    for playerProfile in statsSeason.get_normalized_dict()["LeagueDashPlayerStats"]:

        if (playerProfile['PLAYER_NAME'] != None and playerProfile['PLAYER_ID'] in ids_set and playerProfile['GP'] > 0
            and playerProfile['TEAM_ABBREVIATION'] in teamAbbreviations and playerProfile['PLAYER_ID'] not in coveredPlayers):
            
            player_data = {
                "id": playerProfile['PLAYER_ID'],
                "name": playerProfile['PLAYER_NAME'],
                "imageURL": "https://cdn.nba.com/headshots/nba/latest/1040x760/{}.png".format(playerProfile['PLAYER_ID']),
                "PPG": round(tempDict[playerProfile['PLAYER_ID']][0]/tempDict[playerProfile['PLAYER_ID']][5],1),
                "RPG": round(tempDict[playerProfile['PLAYER_ID']][1]/tempDict[playerProfile['PLAYER_ID']][5],1),
                "AST": round(tempDict[playerProfile['PLAYER_ID']][2]/tempDict[playerProfile['PLAYER_ID']][5],1),
                "STL": round(tempDict[playerProfile['PLAYER_ID']][3]/tempDict[playerProfile['PLAYER_ID']][5],1),
                "BLK": round(tempDict[playerProfile['PLAYER_ID']][4]/tempDict[playerProfile['PLAYER_ID']][5],1),
                "FG%": playerProfile['FG_PCT'],
                "3P%": playerProfile['FG3_PCT'],
            }
            
            output.append(player_data)
            coveredPlayers.add(playerProfile['PLAYER_ID'])
    #print(output)
    with open("BasicStatsJsonFile.json", "w") as json_file:
        json.dump(output, json_file, indent=4)
    return json.dumps(output, indent = 2)
print(getProccesableJson())