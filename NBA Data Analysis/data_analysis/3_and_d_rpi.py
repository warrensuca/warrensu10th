#data set
import pandas as pd
from scipy.stats import zscore
#python -m venv myenv
#source myenv/bin/activate
#python data_analysis/3_and_d_rpi.py


#decative()

df_traditional = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='filtered_players_traditional', engine='openpyxl')

df_advanced = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='filtered_players_advanced', engine='openpyxl')

#parameters used 
df_trad_subset = df_traditional[['Player', 'Team', 'PTS', '3P%', '3PM', '3PA', 'STL', 'BLK', 'PM']]
df_adv_subset = df_advanced[['Player', 'DEFRTG', 'EFG%', 'USG%']]


#combine both traditional stats and advanced stats

df_combined = pd.merge(df_trad_subset, df_adv_subset, on='Player', how='inner')

df_combined['USG%_inv'] = 100 - df_combined['USG%'] #flig usg and defensive rating = lower usg and lower defensvie rating better
df_combined['DEFRTG_inv'] = -1*df_combined['DEFRTG']

df_combined = df_combined.drop_duplicates(subset='Player', keep='first') #remove duplicates

#zscore everything

metrics = ['PTS', '3P%', '3PM', '3PA', 'STL', 'BLK', 'PM', 'DEFRTG_inv', 'EFG%', 'USG%_inv']
for col in metrics:
    df_combined[f"z_{col}"] = zscore(df_combined[col].fillna(df_combined[col].mean()))


df_combined["RPI"] = (0.4 * (df_combined['z_PTS'] + df_combined['z_3P%'] + df_combined['z_3PM'] + df_combined['z_3PA'])
                    +0.35*((df_combined['z_STL'] + df_combined['z_BLK'] +df_combined['z_DEFRTG_inv'])
                    +0.25*(df_combined['z_EFG%'] + df_combined['z_USG%_inv'] + df_combined['z_PM'] )      
                          )
)

df_combined = df_combined.sort_values("RPI", ascending=False)
df_combined.to_excel("data/most_recent/3D_RPI_results.xlsx", index=False)