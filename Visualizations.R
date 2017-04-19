library(tidyverse)
library(tidyr)
library(lubridate)

file.choose()
incidents_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\hatecrime_incidents_2011to13.csv")
reporting_df <- read.csv("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\hatecrime_reporters_2011to13.csv")


#Visualization 1

#Year, Metro Area, Number of Incidents
reporting_df_1 <- reporting_df %>%
group_by(Metro_Area, Master_File_Year) %>%
summarize(Incidents = sum(Number_of_Incidents_Year, na.rm = TRUE))

reporting_df_1$Metro_Area <- as.factor(reporting_df_1$Metro_Area)
reporting_df_1$Master_File_Year <- as.factor(reporting_df_1$Master_File_Year) 

ggplot(reporting_df_1, aes(Master_File_Year, Incidents, col = Metro_Area, fill = Metro_Area)) +
  geom_point()

#OR

#Year, number of Incidents, Race of Offender
incidents_df_1 <- incidents_df %>%
  filter(Anti_Muslim == "Y") %>%
  mutate(Year = year(Incident_Date), count = 1) %>%
  group_by(Year, Quarter) %>%
  summarize(Number_of_Incidents = sum(count))

  #Visualization 2