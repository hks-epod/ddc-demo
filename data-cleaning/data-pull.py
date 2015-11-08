#!/usr/local/bin/python 

from datetime import date, timedelta
import pandas as pd
import os


# Globals
CWD = os.getcwd()
DATADIR = "/Users/angelaambroz/Dropbox (CID)/India Ambient/Data/Clean"

# Inputting aqi_data_old
df = pd.read_stata(DATADIR + "/aqi_data_old.dta")

# Keeping only PM2.5 data.
pm25 = df[['station', 'dt_clean', 'time_clean', 'pm25_aqi_ins', 'pm25_aqi']]

# Keeping only PM2.5 for August.
augpm = pm25[(pm25['dt_clean'].dt.year == 2015) & (pm25['dt_clean'].dt.month == 8)]

# Outputting
# df.to_csv(CWD + "/aqi_data_old.csv")
# pm25.to_csv(CWD + "/aqi_pm25.csv")
augpm.to_csv(CWD + "/august_pm25.csv")


