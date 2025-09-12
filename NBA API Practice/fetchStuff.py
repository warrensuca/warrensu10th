
from nba_api.stats.static import players
from nba_api.stats.endpoints import playercareerstats

from nba_api.stats.endpoints import leaguedashplayerstats
from nba_api.stats.endpoints import boxscoreadvancedv2

import json

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
    #print(statsSeason.get_normalized_dict()["LeagueDashPlayerStats"][:2])

    for playerProfile in statsSeason.get_normalized_dict()["LeagueDashPlayerStats"]:
        if playerProfile['PLAYER_NAME'] != None and playerProfile['PLAYER_ID'] in ids_set and playerProfile['GP'] > 0:
            player_data = {
                "id": playerProfile['PLAYER_ID'],
                "name": playerProfile['PLAYER_NAME'],
                "imageURL": "https://cdn.nba.com/headshots/nba/latest/1040x760/{}.png".format(playerProfile['PLAYER_ID']),
                "PPG": round(playerProfile['PTS']/playerProfile['GP'],1),
                "RPG": round(playerProfile['REB']/playerProfile['GP'],1),
                "AST": round(playerProfile['AST']/playerProfile['GP'],1),
                "STL": round(playerProfile['STL']/playerProfile['GP'],1),
                "BLK": round(playerProfile['BLK']/playerProfile['GP'],1),
                "FG%": playerProfile['FG_PCT'],
                "3P%": playerProfile['FG3_PCT'],
            }
            output.append(player_data)
    #print(output)
    return json.dumps(output, indent = 2)
print(getProccesableJson())
def fetchAllPlayerJson():
    ids = fetchAllPlayerIDs()
    
    players_json = []

    for id in ids:
        try:
            player = Player(id)
            #print(id)
            player_data = {
                "id": player.id,
                "name": player.getName(),
                "imageURL": player.getImageURL(),
                "PPG": player.getPPG(),
                "RPG": player.getRPG(),
                "AST": player.getAST(),
                "STL": player.getSTL(),
                "FG%": player.getPCT(),
                "3P%": player.get3PCT(),
            }
            
        except Exception as e:
            print("invalid player id", id)
            
        else:
            players_json.append(player_data)
    return players_json
    
