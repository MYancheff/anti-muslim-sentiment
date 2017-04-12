full_fbi <- readLines(file("C:\\Users\\tdounias\\Downloads\\HC 2013 (1)\\HC 2013.txt", open = "r"), skipNul = TRUE)
library(tidyverse)
library(lubridate)
library(dplyr)

#Function that counts the nuber of incidents reported by each precinct
count_incidents <- function(x){
  if(substr(full_fbi[x + 1], 1, 1) == "B"){
    return(0)
  }
  if(substr(full_fbi[x + 1], 1, 1) == "I"){
    return(count_incidents(x + 1) + 1)
  }
}

#Sets up some useful counters and variables
fbi_reporting <- vector()
fbi_incidents <- vector()
j <- 1
z <- 1

incident_no <- data.frame()

#creates vector with only reporting precincts
for(i in seq_along(full_fbi)){
  if(substr(full_fbi[i], 1, 1) == "B" && substr(full_fbi[i], 218, 225) != "        "){
    fbi_reporting[j] <- full_fbi[i]
    incident_no[j, 1] <- i
    j <- j + 1
  }
  if(substr(full_fbi[i], 1, 1) == "I"){
  fbi_incidents[z] <- full_fbi[i]
  z <- z + 1
  }
}

#Counts the incidents
for(i in 1:15013){
  incident_no[i, 2] <- count_incidents(incident_no[i, 1])
}
colnames(incident_no) <- c("Number_Original_list", "Number_of_Incidents_Year")

#Next section is for the creation of the fbi precincts dataframe

reporting_df <- data.frame()

#State code variable
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 1] <- substr(fbi_reporting[i], 3, 4)
}

colnames(reporting_df) <- "State_Code"

#State Abreviation Variable
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 2] <- substr(fbi_reporting[i], 5, 6)
}

colnames(reporting_df)[2] <- "State_Abr"

#Country Region variable
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 3] <- substr(fbi_reporting[i], 65, 65)
}

colnames(reporting_df)[3] <- "Country_Region"

for(i in seq_along(fbi_reporting)){
  ifelse(reporting_df[i, 3] == "1", reporting_df[i, 3] <- "NorthEast", 
         ifelse(reporting_df[i, 3] == "2", reporting_df[i, 3] <- "NorthCentral", 
                ifelse(reporting_df[i, 3] == "3", reporting_df[i, 3] <- "South", reporting_df[i, 3] <- "West")))
}

#Agency_Type Variable
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 4] <- substr(fbi_reporting[i], 66, 66)
}

colnames(reporting_df)[4] <- "Agency_Type"

for(i in seq_along(fbi_reporting)){
  ifelse(reporting_df[i, 4] == "0", reporting_df[i, 4] <- "CoveredbyOther", 
         ifelse(reporting_df[i, 4] == "1", reporting_df[i, 4] <- "City", 
                ifelse(reporting_df[i, 4] == "2", reporting_df[i, 4] <- "County", 
                       ifelse(reporting_df[i, 4] == "3", reporting_df[i, 4] <- "Uni/Col", reporting_df[i, 4] <- "StatePolice"))))
}

#Core_City Variable
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 5] <- substr(fbi_reporting[i], 67, 67)
}

colnames(reporting_df)[5] <- "Metro_Area"

for(i in seq_along(fbi_reporting)){
  ifelse(reporting_df[i, 5] == "N", reporting_df[i, 5] <- "0", reporting_df[i, 5] <- "1")
}

#Date ORI was added var
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 6] <- substr(fbi_reporting[i], 14, 21)
}

colnames(reporting_df)[6] <- "Date_Added"

reporting_df[, 6] <- ymd(reporting_df[, 6])

#Date ORI went NIBRS (????)
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 7] <- substr(fbi_reporting[i], 22, 29)
}

colnames(reporting_df)[7] <- "Date_NIBRS"

reporting_df[, 7] <- ymd(reporting_df[, 7])

# 30 59

#City Name
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 8] <- substr(fbi_reporting[i], 30, 59)
  #Find a way to remove spaces
}

colnames(reporting_df)[8] <- "City_Name"

#Pop_Group Codes variable
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 9] <- substr(fbi_reporting[i], 62, 63)
}

colnames(reporting_df)[9] <- "Pop_Group_Code"

#Judicial District Code
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 9] <- substr(fbi_reporting[i], 81, 84)
}

colnames(reporting_df)[9] <- "Judicial_Dist_in_State"

#Is Nibrs Active?
for(i in seq_along(fbi_reporting)){
  ifelse(substr(fbi_reporting[i], 85, 85) == "A", reporting_df[i, 10] <- 1, reporting_df[i, 10] <- 0)
}

colnames(reporting_df)[10] <- "IsActiveNIBRS"

#Current population covered
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 11] <- as.integer(substr(fbi_reporting[i], 94, 100))
}

colnames(reporting_df)[11] <- "Current_Pop"
#Find out what this means

#103 105
#FIPS County Code
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 12] <- substr(fbi_reporting[i], 256, 270)
}

colnames(reporting_df)[12] <- "FIPS_Code"

#UCR County Code
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 13] <- substr(fbi_reporting[i], 103, 105)
}

colnames(reporting_df)[13] <- "UCR_Code"

#MSA Code
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 14] <- substr(fbi_reporting[i], 106, 108)
}

colnames(reporting_df)[14] <- "MSA_Code"

#Last Population
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 15] <- as.integer(substr(fbi_reporting[i], 109, 117))
}

colnames(reporting_df)[15] <- "Last_Population"

#Master File Year
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 16] <- substr(fbi_reporting[i], 214, 217)
}

colnames(reporting_df)[16] <- "Master_File_Year"

#Agency ID
for(i in seq_along(fbi_reporting)){
  reporting_df[i, 17] <- substr(fbi_reporting[i], 5, 13)
}

colnames(reporting_df)[17] <- "Agency_ID"

#Quarters of Activity
for(i in seq_along(fbi_reporting)){
  c <- 0
  for(y in c(218:221)){
    reporting_df[i, 18 + c] <- substr(fbi_reporting[i], y, y)
    c <- c + 1
  }
}

colnames(reporting_df)[18] <- "1"
colnames(reporting_df)[19] <- "2"
colnames(reporting_df)[20] <- "3"
colnames(reporting_df)[21] <- "4"

#Bind this before gathering
reporting_df <- cbind(reporting_df, incident_no)

reporting_df <- reporting_df %>%
  gather(key = Quarter, value = Incidents, 18, 19, 20, 21)


#Next section is on the fbi incidents reported.

incidents_df <- data.frame()

#State Code
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 1] <- substr(fbi_incidents[i], 3, 4)
}

colnames(incidents_df) <- "State_Code"

#Agency ID
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 2] <- substr(fbi_incidents[i], 5, 13)
}

colnames(incidents_df)[2] <- "Agency_ID"

#Incident Date
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 3] <- substr(fbi_incidents[i], 26, 33)
}

incidents_df[, 3] <- ymd(incidents_df[, 3])

colnames(incidents_df)[3] <- "Incident_Date"

#Quarter
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 4] <- substr(fbi_incidents[i], 35, 35)
}

colnames(incidents_df)[4] <- "Quarter"

#Number of Victims
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 5] <- as.integer(substr(fbi_incidents[i], 36, 38))
}

colnames(incidents_df)[5] <- "Victims"

#Offenders number
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 6] <- as.integer(substr(fbi_incidents[i], 39, 40))
}

colnames(incidents_df)[6] <- "Offenders"

#Offender's Race
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 7] <- substr(fbi_incidents[i], 41, 41)
}

colnames(incidents_df)[7] <- "Offender_Race"

#UCR Offense Code
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 8] <- substr(fbi_incidents[i], 42, 44)
}

colnames(incidents_df)[8] <- "UCR_Code"

#Location
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 9] <- substr(fbi_incidents[i], 48, 49)
}

colnames(incidents_df)[9] <- "Location_Code"

#Bias Motivation
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 10] <- substr(fbi_incidents[i], 50, 51)
}

colnames(incidents_df)[10] <- "Bias_Motivation"

#Is it anti-Muslim?
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 11] <- ifelse(incidents_df[i, 10] == "24", "Y", "N")
}

colnames(incidents_df)[11] <- "Anti_Muslim"

#Type of victim
for(i in seq_along(fbi_incidents)){
  incidents_df[i, 12] <- substr(fbi_incidents[i], 52, 59)
}

colnames(incidents_df)[12] <- "Victim_Type"




