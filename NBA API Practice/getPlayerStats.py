from nba_api.stats.static import players
from nba_api.stats.endpoints import playercareerstats

from nba_api.stats.endpoints import leaguedashplayerstats


# get_players returns a list of dictionaries, each representing a player.
nba_players = players.get_active_players()
print("Number of players fetched: {}".format(len(nba_players)))
ids = []
for i in range(len(nba_players)):


    ids.append(nba_players[i]['id'])
print(nba_players[:5])
print(ids[:5])

statsSeason = leaguedashplayerstats.LeagueDashPlayerStats(season='2024-25')
df = statsSeason.get_data_frames()[0]


davis = playercareerstats.PlayerCareerStats(player_id="203076")
print(davis.get_normalized_dict().keys())
print('\n')
print(davis.get_normalized_dict()['SeasonTotalsRegularSeason'][0])
print(davis.get_normalized_dict()['CareerTotalsRegularSeason'][0])
davisDict = davis.get_normalized_dict()
avgPoints = 0
seasons = davisDict['SeasonTotalsRegularSeason']
for i in range(len(seasons)):
    avgPoints += seasons[i]['PTS']/seasons[i]['GP']
print(avgPoints/len(seasons))

class Player:
    def __init__(self, id):
        self.id = id
        self.playerstats = playercareerstats.PlayerCareerStats(player_id="203076")
        self.regularSeasons = self.playerstats.get_normalized_dict()['SeasonTotalsRegularSeason']
        self.totals = self.playerstats.get_normalized_dict()['CareerTotalsRegularSeason']

    def getPPG():
        
        return (self.totals['PTS']/self.totals['GP'])
        
    def getRPG():
        return (self.totals['REB']/self.totals['GP'])
    
    def getAST():
        return (self.totals['AST']/self.totals['GP'])
    
    def getSTL():
        avgSTL = 0
        for i in range(len(seasons)):
            avgSTL += seasons[i]['STL']/seasons[i]['GP']
        return (self.totals['AST']/self.totals['GP'])
    
    