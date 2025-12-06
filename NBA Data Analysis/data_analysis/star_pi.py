#data set
import pandas as pd
from scipy.stats import zscore
#python -m venv myenv
#source myenv/bin/activate
#python python data_analysis/star_pi.py   


#decative()

df_traditional = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='valid_players_traditional', engine='openpyxl')

df_advanced = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='valid_players_advanced', engine='openpyxl')

#parameters used 
df_trad_subset = df_traditional[['Player', 'Team', 'PTS', 'FGM', 'FGA', '3P%', '3PM', '3PA', 'STL', 'BLK', 'PM']]
df_adv_subset = df_advanced[['Player', 'DEFRTG', 'EFG%', 'USG%']]


#combine both traditional stats and advanced stats

df_combined = pd.merge(df_trad_subset, df_adv_subset, on='Player', how='inner')

df_combined['DEFRTG_inv'] = -1*df_combined['DEFRTG']

df_combined = df_combined.drop_duplicates(subset='Player', keep='first') #remove duplicates

#zscore everything

metrics = ['PTS', '3P%', 'FGM', 'FGA', '3PM', '3PA', 'STL', 'BLK', 'PM', 'DEFRTG_inv', 'EFG%', 'USG%']
for col in metrics:
    df_combined[f"z_{col}"] = zscore(df_combined[col].fillna(df_combined[col].mean()))


df_combined['SPI'] = (
    0.6 * (df_combined['z_PTS'] + df_combined['z_FGM'] + df_combined['z_FGA']+ df_combined['z_3PM'] 
           + df_combined['z_3PA'] + df_combined['z_USG%'])
    + 0.3 * (df_combined['z_STL'] + df_combined['z_BLK'] + + df_combined['z_DEFRTG_inv'])
    + 0.1 * (df_combined['z_3P%'] + df_combined['z_EFG%'] + df_combined['z_PM'])
)

df_combined = df_combined.sort_values("SPI", ascending=False)
df_combined.to_excel("data/most_recent/SPI_results.xlsx", index=False)

