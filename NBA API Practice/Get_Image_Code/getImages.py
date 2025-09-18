import urllib.request
from PIL import Image

from nba_api.stats.static import players
from nba_api.stats.endpoints import playercareerstats

from nba_api.stats.endpoints import leaguedashplayerstats
from nba_api.stats.endpoints import boxscoreadvancedv2
import ssl
import urllib.request

ssl._create_default_https_context = ssl._create_unverified_context
def fetchAllPlayerIDs():
    ids = []
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])
    print("Number of players fetched: {}".format(len(nba_players)))
    return ids
    

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

            

downloadAllPlayerImages()