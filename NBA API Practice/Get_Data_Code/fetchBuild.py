from nba_api.stats.static import players
from nba_api.stats.endpoints import commonplayerinfo
import time
import json
import numpy as np
player_id = 1628408
info = commonplayerinfo.CommonPlayerInfo(player_id=player_id)

data = info.get_normalized_dict()
player_info = data['CommonPlayerInfo'][0]


height = player_info['HEIGHT']
print(int(height[0])*12 + int(height[2]))

def get_ids():
    ids = []
    nba_players = players.get_active_players()
    for i in range(len(nba_players)):


        ids.append(nba_players[i]['id'])

    return ids
def get_builds():
    ids = get_ids()
    builds = {}

    for id in ids:
        #print(id)
        info = commonplayerinfo.CommonPlayerInfo(player_id=id)
        data = info.get_normalized_dict()
        player_info = data['CommonPlayerInfo'][0]
        height = player_info['HEIGHT']

        weight = player_info['WEIGHT'] 
        if weight == '':
            weight = 225

        
        builds[id] = {"Height": int(height[0])*12 + int(height[2:]), "Weight": int(weight)}
        print(builds)
        time.sleep(0.5)
    return builds
def get_builds_json():
    data = get_builds() #takes too long to run each time, should save the dict i get
    #data = [{1630173: {'Height': 80, 'Weight': 243}}, {203500: {'Height': 83, 'Weight': 265}}, {1628389: {'Height': 81, 'Weight': 255}}, {1630534: {'Height': 77, 'Weight': 215}}, {1630583: {'Height': 84, 'Weight': 215}}, {1641725: {'Height': 77, 'Weight': 185}}, {1629638: {'Height': 77, 'Weight': 205}}, {1628960: {'Height': 75, 'Weight': 198}}, {1628386: {'Height': 81, 'Weight': 243}}, {1630631: {'Height': 72, 'Weight': 179}}, {203937: {'Height': 80, 'Weight': 230}}, {203507: {'Height': 83, 'Weight': 243}}, {1630175: {'Height': 74, 'Weight': 185}}, {1628384: {'Height': 79, 'Weight': 240}}, {1642379: {'Height': 77, 'Weight': 190}}, {1630166: {'Height': 80, 'Weight': 228}}, {1629028: {'Height': 84, 'Weight': 252}}, {1630542: {'Height': 78, 'Weight': 217}}, {1628963: {'Height': 82, 'Weight': 235}}, {1631116: {'Height': 81, 'Weight': 220}}, {1630163: {'Height': 79, 'Weight': 180}}, {1628366: {'Height': 77, 'Weight': 190}}, {1628964: {'Height': 84, 'Weight': 231}}, {1631094: {'Height': 82, 'Weight': 250}}, {1630217: {'Height': 78, 'Weight': 215}}, {1630625: {'Height': 80, 'Weight': 203}}, {1631230: {'Height': 81, 'Weight': 215}}, {203084: {'Height': 79, 'Weight': 225}}, {1630567: {'Height': 80, 'Weight': 237}}, {1629628: {'Height': 78, 'Weight': 214}}, {1629646: {'Height': 82, 'Weight': 230}}, {1641734: {'Height': 80, 'Weight': 202}}, {1642419: {'Height': 79, 'Weight': 220}}, {201587: {'Height': 79, 'Weight': 230}}, {1641878: {'Height': 76, 'Weight': 194}}, {203078: {'Height': 76, 'Weight': 207}}, {1627736: {'Height': 76, 'Weight': 187}}, {1630699: {'Height': 79, 'Weight': 199}}, {1641736: {'Height': 75, 'Weight': 190}}, {1630180: {'Height': 80, 'Weight': 215}}, {1629048: {'Height': 83, 'Weight': 250}}, {202687: {'Height': 80, 'Weight': 255}}, {1641710: {'Height': 79, 'Weight': 200}}, {203992: {'Height': 77, 'Weight': 225}}, {1629626: {'Height': 87, 'Weight': 220}}, {1641737: {'Height': 82, 'Weight': 235}}, {1626164: {'Height': 77, 'Weight': 206}}, {1630527: {'Height': 78, 'Weight': 188}}, {1628449: {'Height': 80, 'Weight': 200}}, {1631123: {'Height': 74, 'Weight': 180}}, {1628396: {'Height': 82, 'Weight': 248}}, {1631103: {'Height': 76, 'Weight': 180}}, {1631128: {'Height': 78, 'Weight': 220}}, {1641779: {'Height': 80, 'Weight': 225}}, {1628969: {'Height': 78, 'Weight': 209}}, {1628970: {'Height': 79, 'Weight': 225}}, {1629052: {'Height': 79, 'Weight': 210}}, {1627763: {'Height': 76, 'Weight': 229}}, {1628415: {'Height': 79, 'Weight': 225}}, {1631232: {'Height': 79, 'Weight': 210}}, {1628971: {'Height': 76, 'Weight': 202}}, {1627759: {'Height': 78, 'Weight': 223}}, {1641738: {'Height': 79, 'Weight': 250}}, {1629650: {'Height': 86, 'Weight': 258}}, {1628973: {'Height': 74, 'Weight': 190}}, {1628418: {'Height': 81, 'Weight': 248}}, {1641723: {'Height': 76, 'Weight': 195}}, {202692: {'Height': 77, 'Weight': 214}}, {1630215: {'Height': 75, 'Weight': 193}}, {202710: {'Height': 78, 'Weight': 230}}, {1641824: {'Height': 80, 'Weight': 209}}, {1631288: {'Height': 79, 'Weight': 191}}, {203484: {'Height': 77, 'Weight': 204}}, {1641739: {'Height': 79, 'Weight': 230}}, {203991: {'Height': 82, 'Weight': 256}}, {1642382: {'Height': 84, 'Weight': 220}}, {1642267: {'Height': 76, 'Weight': 190}}, {1642269: {'Height': 74, 'Weight': 195}}, {1628975: {'Height': 72, 'Weight': 200}}, {1628976: {'Height': 82, 'Weight': 270}}, {1630618: {'Height': 75, 'Weight': 200}}, {1627936: {'Height': 77, 'Weight': 186}}, {1642264: {'Height': 78, 'Weight': 215}}, {1630658: {'Height': 82, 'Weight': 250}}, {1630577: {'Height': 79, 'Weight': 217}}, {1630551: {'Height': 78, 'Weight': 206}}, {1642279: {'Height': 83, 'Weight': 235}}, {1642353: {'Height': 77, 'Weight': 190}}, {1631108: {'Height': 77, 'Weight': 190}}, {1630528: {'Height': 76, 'Weight': 215}}, {1631321: {'Height': 78, 'Weight': 220}}, {1641740: {'Height': 77, 'Weight': 205}}, {1629634: {'Height': 80, 'Weight': 215}}, {203903: {'Height': 77, 'Weight': 194}}, {1629651: {'Height': 83, 'Weight': 215}}, {1642270: {'Height': 86, 'Weight': 280}}, {1641730: {'Height': 82, 'Weight': 210}}, {1629599: {'Height': 79, 'Weight': 210}}, {1642268: {'Height': 76, 'Weight': 210}}, {1628381: {'Height': 81, 'Weight': 226}}, {1641879: {'Height': 72, 'Weight': 190}}, {1628380: {'Height': 81, 'Weight': 250}}, {201144: {'Height': 73, 'Weight': 175}}, {1626192: {'Height': 77, 'Weight': 209}}, {1641731: {'Height': 79, 'Weight': 195}}, {1641741: {'Height': 78, 'Weight': 207}}, {1628470: {'Height': 77, 'Weight': 221}}, {1642384: {'Height': 78, 'Weight': 220}}, {203109: {'Height': 78, 'Weight': 235}}, {1630595: {'Height': 78, 'Weight': 220}}, {203552: {'Height': 73, 'Weight': 185}}, {201939: {'Height': 74, 'Weight': 185}}, {1642359: {'Height': 81, 'Weight': 210}}, {1630700: {'Height': 79, 'Weight': 199}}, {1642368: {'Height': 83, 'Weight': 230}}, {203076: {'Height': 82, 'Weight': 253}}, {1631098: {'Height': 76, 'Weight': 195}}, {1631120: {'Height': 73, 'Weight': 195}}, {201942: {'Height': 78, 'Weight': 220}}, {1642484: {'Height': 73, 'Weight': 180}}, {1628978: {'Height': 76, 'Weight': 203}}, {1631217: {'Height': 82, 'Weight': 210}}, {1641711: {'Height': 79, 'Weight': 200}}, {1631172: {'Height': 81, 'Weight': 185}}, {1642265: {'Height': 74, 'Weight': 175}}, {203915: {'Height': 77, 'Weight': 215}}, {1629029: {'Height': 80, 'Weight': 230}}, {1629652: {'Height': 76, 'Weight': 220}}, {1630245: {'Height': 76, 'Weight': 200}}, {1630288: {'Height': 75, 'Weight': 177}}, {1628408: {'Height': 78, 'Weight': 205}}, {203083: {'Height': 83, 'Weight': 279}}, {1630537: {'Height': 77, 'Weight': 190}}, {1642505: {'Height': 79, 'Weight': 220}}, {1630561: {'Height': 76, 'Weight': 204}}, {1627739: {'Height': 75, 'Weight': 205}}, {1642346: {'Height': 79, 'Weight': 216}}, {201142: {'Height': 83, 'Weight': 240}}, {1631105: {'Height': 82, 'Weight': 250}}, {1631106: {'Height': 80, 'Weight': 215}}, {1641744: {'Height': 87, 'Weight': 305}}, {1630162: {'Height': 76, 'Weight': 225}}, {1642399: {'Height': 84, 'Weight': 236}}, {1642348: {'Height': 79, 'Weight': 203}}, {1630556: {'Height': 79, 'Weight': 203}}, {1631165: {'Height': 76, 'Weight': 175}}, {203954: {'Height': 84, 'Weight': 280}}, {1630623: {'Height': 72, 'Weight': 200}}, {1629234: {'Height': 82, 'Weight': 245}}, {1641787: {'Height': 80, 'Weight': 217}}, {203957: {'Height': 77, 'Weight': 214}}, {1628981: {'Height': 81, 'Weight': 240}}, {1642271: {'Height': 83, 'Weight': 250}}, {1627827: {'Height': 79, 'Weight': 220}}, {1641745: {'Height': 75, 'Weight': 180}}, {1642280: {'Height': 81, 'Weight': 185}}, {1630201: {'Height': 73, 'Weight': 185}}, {1631323: {'Height': 79, 'Weight': 209}}, {1628368: {'Height': 75, 'Weight': 185}}, {1642402: {'Height': 81, 'Weight': 220}}, {1628365: {'Height': 76, 'Weight': 209}}, {1642277: {'Height': 80, 'Weight': 200}}, {1629655: {'Height': 82, 'Weight': 265}}, {1629636: {'Height': 73, 'Weight': 192}}, {1630585: {'Height': 77, 'Weight': 205}}, {1630568: {'Height': 82, 'Weight': 243}}, {1641718: {'Height': 76, 'Weight': 185}}, {1642273: {'Height': 80, 'Weight': 200}}, {202331: {'Height': 80, 'Weight': 220}}, {201959: {'Height': 81, 'Weight': 232}}, {1630581: {'Height': 79, 'Weight': 216}}, {1628983: {'Height': 78, 'Weight': 195}}, {1630264: {'Height': 79, 'Weight': 230}}, {1631221: {'Height': 73, 'Weight': 195}}, {203497: {'Height': 85, 'Weight': 258}}, {1630692: {'Height': 75, 'Weight': 215}}, {203932: {'Height': 80, 'Weight': 235}}, {201569: {'Height': 75, 'Weight': 215}}, {1641789: {'Height': 74, 'Weight': 184}}, {203924: {'Height': 79, 'Weight': 213}}, {1631260: {'Height': 76, 'Weight': 190}}, {203110: {'Height': 78, 'Weight': 230}}, {1630224: {'Height': 76, 'Weight': 186}}, {1629750: {'Height': 77, 'Weight': 205}}, {201145: {'Height': 80, 'Weight': 235}}, {1630182: {'Height': 78, 'Weight': 200}}, {1629656: {'Height': 76, 'Weight': 210}}, {1631243: {'Height': 83, 'Weight': 210}}, {1629060: {'Height': 80, 'Weight': 230}}, {1630169: {'Height': 77, 'Weight': 185}}, {1641790: {'Height': 80, 'Weight': 245}}, {203501: {'Height': 77, 'Weight': 205}}, {201935: {'Height': 77, 'Weight': 220}}, {1630702: {'Height': 75, 'Weight': 198}}, {1641989: {'Height': 75, 'Weight': 195}}, {1631199: {'Height': 77, 'Weight': 233}}, {203914: {'Height': 76, 'Weight': 210}}, {202699: {'Height': 80, 'Weight': 226}}, {1628404: {'Height': 77, 'Weight': 215}}, {1628392: {'Height': 84, 'Weight': 250}}, {1630573: {'Height': 79, 'Weight': 217}}, {1641722: {'Height': 77, 'Weight': 190}}, {1629637: {'Height': 84, 'Weight': 220}}, {1630165: {'Height': 77, 'Weight': 195}}, {1630703: {'Height': 75, 'Weight': 207}}, {1641707: {'Height': 81, 'Weight': 215}}, {1629639: {'Height': 77, 'Weight': 195}}, {1627741: {'Height': 76, 'Weight': 220}}, {1629312: {'Height': 77, 'Weight': 220}}, {1628988: {'Height': 72, 'Weight': 185}}, {201950: {'Height': 76, 'Weight': 220}}, {1641842: {'Height': 80, 'Weight': 206}}, {1626158: {'Height': 81, 'Weight': 235}}, {1641747: {'Height': 81, 'Weight': 225}}, {1631096: {'Height': 85, 'Weight': 208}}, {1641720: {'Height': 77, 'Weight': 210}}, {201143: {'Height': 80, 'Weight': 240}}, {1629659: {'Height': 76, 'Weight': 234}}, {1631216: {'Height': 80, 'Weight': 205}}, {1641724: {'Height': 80, 'Weight': 215}}, {1628989: {'Height': 78, 'Weight': 198}}, {1630643: {'Height': 85, 'Weight': 240}}, {1630574: {'Height': 84, 'Weight': 246}}, {1629631: {'Height': 79, 'Weight': 221}}, {1630538: {'Height': 74, 'Weight': 169}}, {1642345: {'Height': 83, 'Weight': 235}}, {204060: {'Height': 80, 'Weight': 220}}, {1627742: {'Height': 80, 'Weight': 190}}, {1631127: {'Height': 77, 'Weight': 230}}, {202681: {'Height': 74, 'Weight': 195}}, {1628371: {'Height': 82, 'Weight': 230}}, {1631093: {'Height': 75, 'Weight': 195}}, {1641713: {'Height': 81, 'Weight': 210}}, {1630543: {'Height': 80, 'Weight': 205}}, {1631245: {'Height': 76, 'Weight': 173}}, {202704: {'Height': 74, 'Weight': 208}}, {1641748: {'Height': 78, 'Weight': 209}}, {1628991: {'Height': 82, 'Weight': 242}}, {1631218: {'Height': 81, 'Weight': 245}}, {1642355: {'Height': 74, 'Weight': 210}}, {2544: {'Height': 81, 'Weight': 250}}, {1631170: {'Height': 78, 'Weight': 225}}, {1629610: {'Height': 77, 'Weight': 222}}, {1641998: {'Height': 82, 'Weight': 270}}, {1642450: {'Height': 76, 'Weight': 165}}, {1629660: {'Height': 77, 'Weight': 195}}, {1630198: {'Height': 76, 'Weight': 165}}, {1642358: {'Height': 77, 'Weight': 160}}, {1629661: {'Height': 80, 'Weight': 210}}, {1630552: {'Height': 80, 'Weight': 219}}, {201949: {'Height': 79, 'Weight': 240}}, {1629640: {'Height': 78, 'Weight': 220}}, {1630553: {'Height': 77, 'Weight': 185}}, {1642352: {'Height': 78, 'Weight': 225}}, {203999: {'Height': 83, 'Weight': 284}}, {1641732: {'Height': 78, 'Weight': 207}}, {1641794: {'Height': 77, 'Weight': 235}}, {1630529: {'Height': 79, 'Weight': 206}}, {1642403: {'Height': 80, 'Weight': 245}}, {1630539: {'Height': 83, 'Weight': 221}}, {1630222: {'Height': 76, 'Weight': 200}}, {1642461: {'Height': 79, 'Weight': 225}}, {1630200: {'Height': 73, 'Weight': 185}}, {1626145: {'Height': 72, 'Weight': 196}}, {1627884: {'Height': 78, 'Weight': 210}}, {201599: {'Height': 83, 'Weight': 265}}, {202709: {'Height': 74, 'Weight': 200}}, {1631107: {'Height': 82, 'Weight': 205}}, {1630548: {'Height': 79, 'Weight': 226}}, {1642530: {'Height': 68, 'Weight': 159}}, {1630283: {'Height': 84, 'Weight': 215}}, {1628379: {'Height': 77, 'Weight': 206}}, {1631117: {'Height': 86, 'Weight': 245}}, {1630296: {'Height': 80, 'Weight': 225}}, {1630557: {'Height': 78, 'Weight': 224}}, {1628467: {'Height': 82, 'Weight': 240}}, {1641752: {'Height': 81, 'Weight': 225}}, {1642261: {'Height': 78, 'Weight': 215}}, {1628995: {'Height': 80, 'Weight': 215}}, {1642278: {'Height': 74, 'Weight': 195}}, {1631132: {'Height': 83, 'Weight': 225}}, {1629723: {'Height': 77, 'Weight': 210}}, {1628436: {'Height': 85, 'Weight': 250}}, {1630249: {'Height': 80, 'Weight': 195}}, {1630228: {'Height': 79, 'Weight': 225}}, {1628398: {'Height': 80, 'Weight': 221}}, {1631222: {'Height': 79, 'Weight': 235}}, {203897: {'Height': 77, 'Weight': 200}}, {1627746: {'Height': 82, 'Weight': 235}}, {1629111: {'Height': 83, 'Weight': 255}}, {1641796: {'Height': 77, 'Weight': 215}}, {1630639: {'Height': 78, 'Weight': 179}}, {1627747: {'Height': 79, 'Weight': 205}}, {1627814: {'Height': 78, 'Weight': 210}}, {203458: {'Height': 84, 'Weight': 250}}, {202695: {'Height': 78, 'Weight': 225}}, {1642502: {'Height': 81, 'Weight': 210}}, {1641721: {'Height': 79, 'Weight': 215}}, {1630604: {'Height': 78, 'Weight': 240}}, {203081: {'Height': 74, 'Weight': 200}}, {1641726: {'Height': 85, 'Weight': 230}}, {1641753: {'Height': 78, 'Weight': 220}}, {1626172: {'Height': 81, 'Weight': 222}}, {201572: {'Height': 85, 'Weight': 282}}, {201567: {'Height': 82, 'Weight': 251}}, {200768: {'Height': 72, 'Weight': 196}}, {1641754: {'Height': 76, 'Weight': 220}}, {1626168: {'Height': 81, 'Weight': 234}}, {1630572: {'Height': 81, 'Weight': 240}}, {1629611: {'Height': 78, 'Weight': 215}}, {1630544: {'Height': 76, 'Weight': 178}}, {1628374: {'Height': 85, 'Weight': 240}}, {1630230: {'Height': 78, 'Weight': 220}}, {1628997: {'Height': 77, 'Weight': 205}}, {1628998: {'Height': 78, 'Weight': 205}}, {1641798: {'Height': 78, 'Weight': 216}}, {1630231: {'Height': 78, 'Weight': 215}}, {1631213: {'Height': 78, 'Weight': 215}}, {1629726: {'Height': 78, 'Weight': 215}}, {1631097: {'Height': 77, 'Weight': 210}}, {1631255: {'Height': 82, 'Weight': 231}}, {1630178: {'Height': 74, 'Weight': 200}}, {1630540: {'Height': 74, 'Weight': 195}}, {1642272: {'Height': 75, 'Weight': 195}}, {1630644: {'Height': 74, 'Weight': 185}}, {203468: {'Height': 75, 'Weight': 190}}, {204456: {'Height': 73, 'Weight': 190}}, {1641755: {'Height': 78, 'Weight': 210}}, {1630183: {'Height': 81, 'Weight': 185}}, {1629667: {'Height': 81, 'Weight': 190}}, {203926: {'Height': 79, 'Weight': 225}}, {1631121: {'Height': 78, 'Weight': 190}}, {1629162: {'Height': 71, 'Weight': 185}}, {1629098: {'Height': 80, 'Weight': 215}}, {1629001: {'Height': 74, 'Weight': 200}}, {1630241: {'Height': 76, 'Weight': 205}}, {203995: {'Height': 75, 'Weight': 188}}, {203114: {'Height': 79, 'Weight': 222}}, {1641706: {'Height': 79, 'Weight': 200}}, {1641801: {'Height': 77, 'Weight': 215}}, {1641757: {'Height': 77, 'Weight': 194}}, {1631159: {'Height': 82, 'Weight': 220}}, {201988: {'Height': 74, 'Weight': 180}}, {1629003: {'Height': 77, 'Weight': 205}}, {1631303: {'Height': 77, 'Weight': 205}}, {1642434: {'Height': 79, 'Weight': 230}}, {1631169: {'Height': 80, 'Weight': 205}}, {1642274: {'Height': 83, 'Weight': 235}}, {1642349: {'Height': 76, 'Weight': 190}}, {1630558: {'Height': 72, 'Weight': 202}}, {1628378: {'Height': 74, 'Weight': 215}}, {1630596: {'Height': 83, 'Weight': 215}}, {1642367: {'Height': 81, 'Weight': 225}}, {1628370: {'Height': 75, 'Weight': 200}}, {1630541: {'Height': 77, 'Weight': 211}}, {1631386: {'Height': 77, 'Weight': 195}}, {1631111: {'Height': 77, 'Weight': 215}}, {1629630: {'Height': 74, 'Weight': 174}}, {202693: {'Height': 81, 'Weight': 245}}, {1628420: {'Height': 74, 'Weight': 183}}, {1630530: {'Height': 80, 'Weight': 206}}, {1627749: {'Height': 76, 'Weight': 180}}, {1627750: {'Height': 76, 'Weight': 215}}, {1631099: {'Height': 80, 'Weight': 225}}, {1631200: {'Height': 80, 'Weight': 218}}, {1629004: {'Height': 79, 'Weight': 205}}, {1631250: {'Height': 81, 'Weight': 225}}, {1626204: {'Height': 78, 'Weight': 245}}, {1629614: {'Height': 76, 'Weight': 191}}, {1630174: {'Height': 77, 'Weight': 215}}, {1641803: {'Height': 77, 'Weight': 190}}, {1627777: {'Height': 78, 'Weight': 230}}, {1630227: {'Height': 76, 'Weight': 238}}, {1630192: {'Height': 82, 'Weight': 240}}, {1641936: {'Height': 79, 'Weight': 220}}, {1629669: {'Height': 76, 'Weight': 201}}, {203994: {'Height': 83, 'Weight': 290}}, {1626220: {'Height': 78, 'Weight': 226}}, {1626143: {'Height': 82, 'Weight': 270}}, {1629643: {'Height': 79, 'Weight': 229}}, {1629006: {'Height': 76, 'Weight': 213}}, {1630168: {'Height': 82, 'Weight': 240}}, {1630171: {'Height': 76, 'Weight': 225}}, {1642439: {'Height': 75, 'Weight': 200}}, {203482: {'Height': 84, 'Weight': 240}}, {1626162: {'Height': 80, 'Weight': 203}}, {101108: {'Height': 72, 'Weight': 175}}, {1626166: {'Height': 75, 'Weight': 183}}, {203901: {'Height': 75, 'Weight': 195}}, {1627780: {'Height': 74, 'Weight': 195}}, {1641809: {'Height': 80, 'Weight': 205}}, {1641763: {'Height': 78, 'Weight': 198}}, {1629618: {'Height': 74, 'Weight': 202}}, {1630590: {'Height': 74, 'Weight': 170}}, {1631342: {'Height': 76, 'Weight': 216}}, {203486: {'Height': 84, 'Weight': 254}}, {1641764: {'Height': 76, 'Weight': 205}}, {1627751: {'Height': 84, 'Weight': 253}}, {1629673: {'Height': 76, 'Weight': 194}}, {1641854: {'Height': 73, 'Weight': 180}}, {1629645: {'Height': 77, 'Weight': 203}}, {1629008: {'Height': 82, 'Weight': 218}}, {1626171: {'Height': 81, 'Weight': 250}}, {204001: {'Height': 86, 'Weight': 240}}, {1642366: {'Height': 84, 'Weight': 238}}, {1630695: {'Height': 81, 'Weight': 248}}, {203939: {'Height': 82, 'Weight': 240}}, {1626181: {'Height': 75, 'Weight': 215}}, {1627752: {'Height': 78, 'Weight': 218}}, {1630202: {'Height': 73, 'Weight': 195}}, {1641765: {'Height': 79, 'Weight': 230}}, {1642389: {'Height': 76, 'Weight': 206}}, {1630243: {'Height': 77, 'Weight': 190}}, {1629674: {'Height': 84, 'Weight': 248}}, {1630193: {'Height': 74, 'Weight': 190}}, {1631311: {'Height': 76, 'Weight': 208}}, {203944: {'Height': 81, 'Weight': 250}}, {1641871: {'Height': 81, 'Weight': 245}}, {1630559: {'Height': 77, 'Weight': 197}}, {1629629: {'Height': 79, 'Weight': 217}}, {1630194: {'Height': 81, 'Weight': 210}}, {1642024: {'Height': 81, 'Weight': 245}}, {1641810: {'Height': 77, 'Weight': 205}}, {1629675: {'Height': 81, 'Weight': 264}}, {1631197: {'Height': 77, 'Weight': 210}}, {1630208: {'Height': 83, 'Weight': 245}}, {1626196: {'Height': 77, 'Weight': 200}}, {1642258: {'Height': 80, 'Weight': 200}}, {1641857: {'Height': 84, 'Weight': 250}}, {1629130: {'Height': 79, 'Weight': 215}}, {1629011: {'Height': 84, 'Weight': 240}}, {1631115: {'Height': 82, 'Weight': 235}}, {1630526: {'Height': 81, 'Weight': 240}}, {1631223: {'Height': 76, 'Weight': 255}}, {1631157: {'Height': 75, 'Weight': 180}}, {1642050: {'Height': 78, 'Weight': 210}}, {1626179: {'Height': 73, 'Weight': 190}}, {1641712: {'Height': 79, 'Weight': 205}}, {1626156: {'Height': 75, 'Weight': 193}}, {1630346: {'Height': 78, 'Weight': 215}}, {1627734: {'Height': 82, 'Weight': 240}}, {1642275: {'Height': 82, 'Weight': 207}}, {1641766: {'Height': 81, 'Weight': 245}}, {1630611: {'Height': 79, 'Weight': 185}}, {1642259: {'Height': 84, 'Weight': 205}}, {1631204: {'Height': 73, 'Weight': 195}}, {1631248: {'Height': 78, 'Weight': 205}}, {203471: {'Height': 73, 'Weight': 175}}, {1630578: {'Height': 83, 'Weight': 243}}, {1641729: {'Height': 78, 'Weight': 235}}, {1629012: {'Height': 75, 'Weight': 190}}, {1629013: {'Height': 77, 'Weight': 190}}, {1630545: {'Height': 78, 'Weight': 215}}, {1630549: {'Height': 82, 'Weight': 265}}, {1631101: {'Height': 77, 'Weight': 210}}, {1642347: {'Height': 73, 'Weight': 200}}, {1641767: {'Height': 78, 'Weight': 190}}, {1642263: {'Height': 74, 'Weight': 185}}, {1627783: {'Height': 80, 'Weight': 245}}, {1627732: {'Height': 82, 'Weight': 240}}, {1629014: {'Height': 75, 'Weight': 200}}, {1642354: {'Height': 74, 'Weight': 189}}, {1630579: {'Height': 82, 'Weight': 250}}, {203935: {'Height': 75, 'Weight': 220}}, {1630696: {'Height': 74, 'Weight': 203}}, {1630188: {'Height': 80, 'Weight': 215}}, {1642449: {'Height': 83, 'Weight': 225}}, {1641890: {'Height': 81, 'Weight': 224}}, {1631095: {'Height': 83, 'Weight': 220}}, {1641733: {'Height': 74, 'Weight': 185}}, {1631110: {'Height': 80, 'Weight': 230}}, {1642285: {'Height': 75, 'Weight': 205}}, {1630311: {'Height': 74, 'Weight': 205}}, {1630531: {'Height': 76, 'Weight': 202}}, {1641815: {'Height': 71, 'Weight': 185}}, {1630205: {'Height': 79, 'Weight': 230}}, {1630191: {'Height': 80, 'Weight': 250}}, {1631124: {'Height': 78, 'Weight': 205}}, {1629622: {'Height': 77, 'Weight': 215}}, {1630591: {'Height': 77, 'Weight': 205}}, {1631306: {'Height': 80, 'Weight': 220}}, {1630256: {'Height': 76, 'Weight': 230}}, {1628369: {'Height': 80, 'Weight': 210}}, {1630678: {'Height': 76, 'Weight': 230}}, {202066: {'Height': 77, 'Weight': 195}}, {1631207: {'Height': 78, 'Weight': 195}}, {1628464: {'Height': 80, 'Weight': 245}}, {1630560: {'Height': 75, 'Weight': 210}}, {1641708: {'Height': 79, 'Weight': 200}}, {1641709: {'Height': 79, 'Weight': 205}}, {1630679: {'Height': 77, 'Weight': 195}}, {202691: {'Height': 77, 'Weight': 220}}, {202684: {'Height': 81, 'Weight': 254}}, {1630550: {'Height': 81, 'Weight': 203}}, {1629680: {'Height': 77, 'Weight': 202}}, {1630214: {'Height': 80, 'Weight': 245}}, {1631166: {'Height': 82, 'Weight': 235}}, {1641772: {'Height': 80, 'Weight': 210}}, {1642260: {'Height': 78, 'Weight': 200}}, {1631210: {'Height': 81, 'Weight': 200}}, {1630167: {'Height': 81, 'Weight': 220}}, {1626157: {'Height': 84, 'Weight': 248}}, {1642422: {'Height': 81, 'Weight': 245}}, {1631247: {'Height': 78, 'Weight': 207}}, {1629018: {'Height': 77, 'Weight': 204}}, {1631131: {'Height': 80, 'Weight': 255}}, {200782: {'Height': 77, 'Weight': 245}}, {1626167: {'Height': 83, 'Weight': 250}}, {1641816: {'Height': 80, 'Weight': 215}}, {1642281: {'Height': 78, 'Weight': 215}}, {1630649: {'Height': 78, 'Weight': 210}}, {202685: {'Height': 83, 'Weight': 265}}, {1627832: {'Height': 72, 'Weight': 197}}, {1629020: {'Height': 80, 'Weight': 214}}, {1630170: {'Height': 77, 'Weight': 200}}, {1629216: {'Height': 74, 'Weight': 200}}, {1641774: {'Height': 84, 'Weight': 220}}, {202696: {'Height': 81, 'Weight': 260}}, {1629731: {'Height': 81, 'Weight': 228}}, {1630532: {'Height': 82, 'Weight': 220}}, {1629021: {'Height': 83, 'Weight': 245}}, {1631133: {'Height': 79, 'Weight': 237}}, {1641716: {'Height': 79, 'Weight': 235}}, {1629022: {'Height': 76, 'Weight': 204}}, {1641717: {'Height': 75, 'Weight': 195}}, {1630811: {'Height': 75, 'Weight': 185}}, {1641775: {'Height': 78, 'Weight': 205}}, {1642266: {'Height': 76, 'Weight': 180}}, {1642276: {'Height': 84, 'Weight': 230}}, {1629023: {'Height': 79, 'Weight': 230}}, {1631102: {'Height': 75, 'Weight': 195}}, {1630322: {'Height': 77, 'Weight': 210}}, {1630570: {'Height': 80, 'Weight': 237}}, {1641817: {'Height': 80, 'Weight': 225}}, {1631212: {'Height': 80, 'Weight': 200}}, {1642377: {'Height': 79, 'Weight': 225}}, {1641705: {'Height': 88, 'Weight': 235}}, {1631104: {'Height': 76, 'Weight': 190}}, {201566: {'Height': 76, 'Weight': 200}}, {1630762: {'Height': 80, 'Weight': 185}}, {1629632: {'Height': 76, 'Weight': 195}}, {1628401: {'Height': 76, 'Weight': 190}}, {1641727: {'Height': 78, 'Weight': 220}}, {1641715: {'Height': 78, 'Weight': 230}}, {1630598: {'Height': 77, 'Weight': 190}}, {203952: {'Height': 78, 'Weight': 197}}, {1631214: {'Height': 76, 'Weight': 210}}, {1630314: {'Height': 73, 'Weight': 190}}, {1642262: {'Height': 80, 'Weight': 190}}, {1629684: {'Height': 79, 'Weight': 236}}, {1631114: {'Height': 77, 'Weight': 211}}, {1631119: {'Height': 81, 'Weight': 240}}, {1629026: {'Height': 79, 'Weight': 210}}, {1631109: {'Height': 85, 'Weight': 240}}, {1631466: {'Height': 77, 'Weight': 205}}, {1630172: {'Height': 78, 'Weight': 215}}, {1630533: {'Height': 81, 'Weight': 185}}, {1629057: {'Height': 81, 'Weight': 249}}, {1631246: {'Height': 76, 'Weight': 205}}, {1629627: {'Height': 78, 'Weight': 284}}, {1630592: {'Height': 78, 'Weight': 220}}, {1630164: {'Height': 83, 'Weight': 240}}, {1631209: {'Height': 75, 'Weight': 185}}, {1626153: {'Height': 77, 'Weight': 185}}, {1627824: {'Height': 79, 'Weight': 265}}, {1642385: {'Height': 77, 'Weight': 190}}, {1642443: {'Height': 72, 'Weight': 185}}, {1629027: {'Height': 74, 'Weight': 164}}, {1627826: {'Height': 84, 'Weight': 240}}, {1641783: {'Height': 80, 'Weight': 217}}, {1628427: {'Height': 80, 'Weight': 236}}, {203967: {'Height': 82, 'Weight': 225}}]
    
    
    with open('data/builds.json', 'w') as f:
       
        json.dump(data, f, indent=4)
    
    
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
    
    
    print(len(data))
    ids = list(data.keys())
    averages = get_average_build()
    std = get_STD_builds()
    
    
    out = {}
    
    for i in range(len(ids)):
        
        
        id = ids[i]
        
        profile = {"Height": (data[id]['Height']-averages['Height'])/std['Height'], 
                   "Weight": (data[id]['Weight']-averages['Weight'])/std['Weight']}
        out[id] = profile
        #print(out)
    with open("data/scaled_builds.json", "w") as json_file:
        json.dump(out, json_file, indent=4)
get_scaled_builds_json()

def combine_all_std_json():
    
    with open('data/scaled_builds.json', 'r') as file:
        builds = json.load(file)
    
    with open('data/STD_scaled_stats_2.json', 'r') as file:
        stats = json.load(file)
    print(len(builds))
    print(len(stats))
    print(builds)
    data = []

    for i in range(len(stats)):
        
        player_stats = stats[i]
        print(player_stats['id'])

        id = str(player_stats['id'])
        print(id)

        player_build = builds[id]
        print(player_build)
        stat_keys = list(player_stats.keys())
        stat_vals = list(player_stats.values())


        #build_keys = list(player_build.keys())
        #build_vals = list(player_build.values())
        
        profile = {}
        for j in range(len(stat_keys)):
            profile[stat_keys[j]] = stat_vals[j]
        profile.update(player_build)
        
        data.append(profile)
    #print(data)
    with open("data/scaled_stats_full.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
#combine_all_std_json()


def get_combine_all_json():
    
    with open('data/builds.json', 'r') as file:
        builds = json.load(file)
    
    with open('data/stats_2.json', 'r') as file:
        stats = json.load(file)

    #print(stats)

    data = []
    print(len(stats))
    print(len(builds))
    for i in range(len(stats)):
        
        player_stats = stats[i]
        print(player_stats['id'])

        id = str(player_stats['id'])
        print(id)

        player_build = builds[id]
        print(player_build)
        stat_keys = list(player_stats.keys())
        stat_vals = list(player_stats.values())


        #build_keys = list(player_build.keys())
        #build_vals = list(player_build.values())
        
        profile = {}
        for j in range(len(stat_keys)):
            profile[stat_keys[j]] = stat_vals[j]
        profile.update(player_build)
        
        data.append(profile)
    #print(data)
    with open("data/stats_full.json", "w") as json_file:
        json.dump(data, json_file, indent=4)
get_combine_all_json()