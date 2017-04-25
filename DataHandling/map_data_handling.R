library(tidyverse)
library(lubridate)

#Read Incident Files
incidents_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\hatecrime_incidents_2011to13.csv")
reporting_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\hatecrime_reporters_2011to13.csv")
popdata_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\Population_data.csv")


hate_crime_map_df <- incidents_df %>%
  mutate(count = 1, Year = year(Incident_Date), State_ID = substr(Agency_ID, 1, 2)) %>%
  group_by(State_Code, State_ID, Year) %>%
  summarize(Muslim_HC = sum(Anti_Muslim == "Y"), General_HC = sum(count))


write.csv(hate_crime_map_df, "map_HC_stats.csv")
