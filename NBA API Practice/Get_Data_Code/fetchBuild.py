from nba_api.stats.static import players
from nba_api.stats.endpoints import commonplayerinfo
import time
import json
player_id = 1630166
info = commonplayerinfo.CommonPlayerInfo(player_id=player_id)

data = info.get_normalized_dict()
player_info = data['CommonPlayerInfo'][0]

print(player_info['HEIGHT'])
print(player_info['WEIGHT'])

print(data)



def get_ids():
    ids = []
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])

    return ids
def get_builds():
    ids = get_ids()
    builds = []

    for id in ids:
        print(id)
        info = commonplayerinfo.CommonPlayerInfo(player_id=id)
        data = info.get_normalized_dict()
        player_info = data['CommonPlayerInfo'][0]
        height = player_info['HEIGHT']

        weight = player_info['WEIGHT'] 
        if weight == '':
            weight = 225

        temp_dict = {"id": id, "Height": int(height[0])*12 + int(height[2]), "Weight": int(weight)}
        builds.append(temp_dict)
        print(builds)
        time.sleep(0.5)
    return builds
def get_builds_json():
    data = get_builds()
    with open("builds.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
    return json.dumps(data, indent = 2)

get_builds_json()