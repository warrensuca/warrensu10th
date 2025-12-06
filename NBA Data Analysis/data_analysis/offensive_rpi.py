#data set
import pandas as pd
import json
#python -m venv myenv
#source myenv/bin/activate

#decative()
# Load the Excel file into a DataFrame
# 'your_file.xlsx' should be replaced with the actual path to your Excel file
# sheet_name can be specified if you have multiple sheets
df = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='rpi sheet', engine='openpyxl')

# Convert the DataFrame to a dictionary
# The 'records' orientation creates a list of dictionaries, where each dictionary
# represents a row in the Excel sheet, with column headers as keys.
data_dict_list = df.to_dict(orient='records')

# Alternatively, to create a dictionary where column names are keys and lists of values are values:
data_dict_columns = df.to_dict(orient='list')


#print(data_dict_list)
#print(data_dict_columns)

names = []
for i in range(len(data_dict_list)):
    player = data_dict_list[i]
    #print(player)
    names.append(player['Player'])
print(names)


with open('data/most_recent/scaled_stats_full_by_name.json', 'r') as file:
    scaled_stats = json.load(file)

f_rpi = []

for i in range(len(names)):

    profile = scaled_stats[names[i]][0]
    
    #0.8(offensive) + 0.2(defensive)
    rpi = (0.8*(profile['PPG'] + profile['AST'] + profile['3P%']) 
            + 0.2 * (profile['RPG'] + profile['STL'] + profile['BLK']) 
            - 0.1*(profile["PF_z"] + profile
            ["TOV_z"]))
    

    
    f_rpi.append({"name": names[i], "rpi": rpi})
    
f_rpi = sorted(f_rpi, key=lambda p: p['rpi'])

print(f_rpi[-20:])
#[{'name': 'Luke Kennard', 'rpi': 1.0830356016080946}, {'name': 'Andrew Nembhard', 'rpi': 1.1465473616977702}, {'name': 'Malik Beasley', 'rpi': 1.1715856241289853}, {'name': 'Bobby Portis', 'rpi': 1.2638621130828187}, {'name': 'Onyeka Okongwu', 'rpi': 1.2809164277003355}, {'name': 'Caris LeVert', 'rpi': 1.3593525947371432}, {'name': 'Khris Middleton', 'rpi': 1.3651994358851995}, {'name': 'Naz Reid', 'rpi': 1.3896387492460887}, {'name': 'Santi Aldama', 'rpi': 1.394826105868505}, {'name': 'Mike Conley', 'rpi': 1.4900768513321463}, {'name': 'Brandin Podziemski', 'rpi': 1.5157095082003644}, {'name': 'Donte DiVincenzo', 'rpi': 1.547383795459656}, {'name': 'Ty Jerome', 'rpi': 1.6004455723121656}, {'name': 'Aaron Gordon', 'rpi': 1.7970551680813014}, {'name': 'Payton Pritchard', 'rpi': 1.8255694249794203}, {'name': 'Scotty Pippen Jr.', 'rpi': 1.9028154053278592}, {'name': 'Draymond Green', 'rpi': 2.0626051899483153}, 
# {'name': 'Chet Holmgren', 'rpi': 2.147113498659176},  #3
# {'name': 'Kristaps Porziņģis', 'rpi': 2.510679649191969}, #2
# {'name': 'Jaren Jackson Jr.', 'rpi': 2.5338702268147055}] #1

d_rpi = []

for i in range(len(names)):

    profile = scaled_stats[names[i]][0]
    
    #0.8(defensive) + 0.2(offensive)
    rpi = (0.2*(profile['PPG'] + profile['AST'] + profile['3P%']) 
            + 0.8 * (profile['RPG'] + profile['STL'] + profile['BLK']) 
            - 0.1*(profile["PF_z"] + profile
            ["TOV_z"]))
    

    
    d_rpi.append({"name": names[i], "rpi": rpi})
    
d_rpi = sorted(d_rpi, key=lambda p: p['rpi'])

print(d_rpi[-20:])
#[{'name': 'Naz Reid', 'rpi': 1.8334094003543666}, {'name': 'Grant Williams', 'rpi': 1.8428788076832052}, {'name': 'Bobby Portis', 'rpi': 1.891932958378931}, {'name': 'Keon Ellis', 'rpi': 1.9394354432759082}, {'name': 'Cason Wallace', 'rpi': 2.1686869560375133}, {'name': 'Goga Bitadze', 'rpi': 2.431896286305261}, {'name': "Kel'el Ware", 'rpi': 2.5060944910691303}, {'name': 'Daniel Gafford', 'rpi': 2.562973268512491}, {'name': 'Zach Edey', 'rpi': 2.635522038562339}, {'name': 'Ausar Thompson', 'rpi': 2.6471453576716186}, {'name': 'Dereck Lively II', 'rpi': 2.7801241466212123}, {'name': 'Jalen Duren', 'rpi': 2.9472091806996783}, {'name': 'Jarrett Allen', 'rpi': 2.981667872739661}, {'name': 'Onyeka Okongwu', 'rpi': 3.10150946168745}, {'name': 'Isaiah Hartenstein', 'rpi': 3.4211184117465163}, {'name': 'Kristaps Porziņģis', 'rpi': 3.46691715928396}, 
# {'name': 'Draymond Green', 'rpi': 3.4907553612349624}, 
# {'name': 'Tari Eason', 'rpi': 3.7279291748056007}, #3
# {'name': 'Jaren Jackson Jr.', 'rpi': 3.8545717355005937} #2, 
# {'name': 'Chet Holmgren', 'rpi': 5.08444171579693}] #1