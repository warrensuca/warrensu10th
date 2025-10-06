from nba_api.stats.static import players
from nba_api.stats.endpoints import shotchartdetail
lebron = players.find_players_by_full_name("LeBron James")[0]
player_id = lebron['id']


shot_chart = shotchartdetail.ShotChartDetail(
    team_id=0,  # 0 = individual player
    player_id=player_id,
    season='2023-24',
    season_type_all_star='Regular Season'
)
shots = shot_chart.get_data_frames()[0] 
print(shots.head()) 