library(tidyverse)
library(tidyr)
library(lubridate)


incidents_df <- read.csv("data-raw/hatecrime_incidents_2011to13.csv")
reporting_df <- read.csv("data-raw/hatecrime_reporters_2011to13.csv")
popdata_df <- read.csv("data-raw/Population_data.csv")

#Visualization 1
viz1 <- incidents_df %>%
  mutate(Year = year(Incident_Date), count = 1) %>%
  group_by(State_Code, Year) %>%
  summarize(No_Non_Muslim = sum(Anti_Muslim == "N"), No_Muslim = sum(Anti_Muslim == "Y"))

region <- reporting_df %>%
  filter(State_Code < 51) %>%
  group_by(State_Code, Master_File_Year, Country_Region) %>%
  summarize()

viz1[, 5] <- region[, 3]

total_pop <- popdata_df %>%
  group_by(Geo_STATE) %>%
  summarize(total_pop = sum(SE_T001_001)) %>%
  rename(State_Code = Geo_STATE)

viz1 <- inner_join(viz1, total_pop, by = "State_Code")

viz1_1 <- viz1 %>%
  mutate(HC_by_pop_nonM = No_Non_Muslim / total_pop, HC_by_pop_M = No_Muslim / total_pop) %>%
  group_by(Country_Region, Year) %>%
  summarize(Mean_Rate_Muslim = mean(HC_by_pop_M), Mean_Rate_Non_Muslim = mean(HC_by_pop_nonM))



#Visualization 2
incidents_df_2 <- incidents_df %>%
  filter(Anti_Muslim == "Y") %>%
  mutate(Year = year(Incident_Date), count = 1) %>%
  group_by(Year, Quarter) %>%
  summarize(Number_of_Incidents = sum(count))



 