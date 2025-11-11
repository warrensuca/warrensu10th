from nba_api.stats.static import players
from nba_api.stats.endpoints import commonplayerinfo
import time
import json
import numpy as np
player_id = 2544
info = commonplayerinfo.CommonPlayerInfo(player_id=player_id)

data = info.get_normalized_dict()
player_info = data['CommonPlayerInfo'][0]




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
        
        time.sleep(0.5)
    return builds
def get_builds_json():
    data = get_builds()
    with open("builds.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
    return json.dumps(data, indent = 2)

#get_builds_json()
def get_average_build():
    with open('Get_Data_Code/builds_copy.json', 'r') as file:
        data = json.load(file)
    out = {"Height": 0, "Weight": 0}
    outKeys = list(out.keys())


    temp = [[player.get(k, 0) for k in outKeys] for player in data]
    statsArr = np.array(temp, dtype=float)  

    stats = np.mean(statsArr, axis=0) 
    

    for i, key in enumerate(outKeys):
        out[key] = round(float(stats[i]), 2)  

    return out
def get_STD_builds():
    with open('Get_Data_Code/builds_copy.json', 'r') as file:
        data = json.load(file)
    #print(data)
    out = {"Height": 0, "Weight": 0}
    outKeys = list(out.keys())

    temp = [[player.get(k, 0) for k in outKeys] for player in data]
    #print(temp)
    statsArr = np.array(temp, dtype=float)  

    
    stds = np.std(statsArr, axis=0)

    for i, key in enumerate(outKeys):
        out[key] = round(float(stds[i]), 2)

    return out

#print(get_STD_builds())



def get_scaled_builds_json():
    with open('data/builds.json', 'r') as file:
        data = json.load(file)
    #print(data)

    ids = get_ids()
    averages = get_average_build()
    std = get_STD_builds()
    print(averages)
    print(std)
    
    out = []
    
    for i in range(len(data)):
        #print(data[i])
        profile = {"id": ids[i], "Height": (data[i]['Height']-averages['Height'])/std['Height'], 
                   "Weight": (data[i]['Weight']-averages['Weight'])/std['Weight']}
        out.append(profile)
        #print(out)
    with open("data/std_scaled_builds.json", "w") as json_file:
        json.dump(out, json_file, indent=4)
get_scaled_builds_json()
