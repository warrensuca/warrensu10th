#data set
import pandas as pd
from scipy.stats import zscore
#python -m venv myenv
#source myenv/bin/activate
#python data_analysis/glue_rpi.py


#deactivate()

df_traditional = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='filtered_players_traditional', engine='openpyxl')

df_advanced = pd.read_excel('data/most_recent/nba.xlsx', sheet_name='filtered_players_advanced', engine='openpyxl')

#parameters used for glue guy metric
df_trad_subset = df_traditional[['Player', 'Team', 'PTS', 'AST', 'STL', 'BLK', 'PM']]
df_adv_subset = df_advanced[['Player', 'DEFRTG', 'EFG%', 'USG%']]


#combine both traditional stats and advanced stats

df_combined = pd.merge(df_trad_subset, df_adv_subset, on='Player', how='inner')

df_combined['USG%_inv'] = 100 - df_combined['USG%']

df_combined = df_combined.drop_duplicates(subset='Player', keep='first') #remove duplicates

#zscore everything

metrics = ['PTS', 'AST', 'EFG%', 'BLK', 'STL', 'DEFRTG', 'PM', 'USG%_inv']
for col in metrics:
    df_combined[f"z_{col}"] = zscore(df_combined[col].fillna(df_combined[col].mean()))


df_combined["RPI"] = (0.35 * (df_combined['z_PTS'] + df_combined['z_AST'] + df_combined['z_EFG%']) +
                                  0.35 * (df_combined['z_BLK'] + df_combined['z_STL'] + df_combined['z_DEFRTG']) +
                                  0.3 * (df_combined['z_PM'] + df_combined['z_USG%_inv'])
)

df_combined = df_combined.sort_values("RPI", ascending=False)
df_combined.to_excel("data/most_recent/glue_rpi_results.xlsx", index=False)