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
print(davis.get_normalized_dict())
print('\n')
print(davis.get_normalized_dict()['SeasonTotalsRegularSeason'][0])
