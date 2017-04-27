library(tidyverse)
library(lubridate)
library(xlsx)

#Read Incident Files
incidents_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\hatecrime_incidents_2011to13.csv")
reporting_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\hatecrime_reporters_2011to13.csv")
census_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\StateCensusTIDY.csv")
FIPS_codes <- read.xlsx2("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\fips_codes_website.xls",
                        sheetIndex = 1, 
                        as.data.frame = TRUE)

#Make FIPS dataframe
FIPS_codes <- FIPS_codes %>%
  group_by(State.FIPS.Code, State.Abbreviation) %>% 
  select(1:2) %>%
  summarize() %>%
  rename(State_ID = State.Abbreviation)

#Make character state codes
FIPS_codes$State_ID <- as.character(FIPS_codes$State_ID)

#Handle census data to remove useless rows
census_df <- census_df %>%
  slice(-46) %>%
  slice(-28) %>%
  slice(-9) 

#Handle hate crime data
hate_crime_df <- incidents_df %>%
  mutate(count = 1, Year = year(Incident_Date), State_ID = substr(Agency_ID, 1, 2)) %>%
  group_by(State_Code, State_ID, Year) %>%
  summarize(Muslim_HC = sum(Anti_Muslim == "Y"), General_HC = sum(count))


hate_crime_df <- inner_join(hate_crime_df, FIPS_codes, "State_ID")

hate_crime_df <- rename(hate_crime_df, Geo_FIPS.x = State.FIPS.Code)

hate_crime_df_2011 <- hate_crime_df %>%
  filter(Year == 2011)

census_df$Geo_FIPS.x <- as.character(census_df$Geo_FIPS.x)

modelling_full_2011 <- inner_join(hate_crime_df_2011, census_df, by = "Geo_FIPS.x")



