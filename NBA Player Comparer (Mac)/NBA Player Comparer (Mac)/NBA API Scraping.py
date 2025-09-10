
from nba_api.stats.static import players
from nba_api.stats.endpoints import playercareerstats

from nba_api.stats.endpoints import leaguedashplayerstats
from nba_api.stats.endpoints import boxscoreadvancedv2



def fetchAllPlayerIDs():
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])
    print("Number of players fetched: {}".format(len(nba_players)))
    return ids
    
class Player:
    def __init__(self, id):
        self.id = id
        self.playerstats = playercareerstats.PlayerCareerStats(player_id="203076")
        self.regularSeasons = self.playerstats.get_normalized_dict()['SeasonTotalsRegularSeason']
        self.totals = self.playerstats.get_normalized_dict()['CareerTotalsRegularSeason']


    def getName(self):
        for i in range(len(nba_players)):
            if nba_players[i]['id'] == self.id:
                return nba_players[i]['full_name']
        
    
    def getimageURL(self):
        return "https://cdn.nba.com/headshots/nba/latest/1040x760/{}.png".format(self.id)

    def getPPG(self):
        
        return (self.totals['PTS']/self.totals['GP'])
        
    def getRPG(self):
        return (self.totals['REB']/self.totals['GP'])
    
    def getAST(self):
        return (self.totals['AST']/self.totals['GP'])
    
    def getSTL(self):
        avgSTL = 0
        for i in range(len(seasons)):
            avgSTL += seasons[i]['STL']/seasons[i]['GP']
        return (self.totals['AST']/self.totals['GP'])
    
    def getPCT(self):
        return (self.totals['FG_PCT'])
    
    def get3PCT(self):
        return (self.totals['FG3_PCT'])
    
