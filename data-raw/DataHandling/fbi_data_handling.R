library(tidyverse)
library(lubridate)
library(dplyr)

full_fbi <- readLines(file("C:\\Users\\tdounias\\Downloads\\HC 2013 (1)\\HC 2013.txt", open = "r"), skipNul = TRUE)

#Function that counts the nuber of incidents reported by each precinct
count_incidents <- function(x){
  if(substr(full_fbi[x + 1], 1, 1) == "B"){
    return(0)
  }
  if(substr(full_fbi[x + 1], 1, 1) == "I"){
    return(count_incidents(x + 1) + 1)
  }
}


#Function for reading data into individual datasets
read_var <- function(data, varname, start, end){
  df <- data.frame()
  for(i in seq_along(data)){
    df[i, 1] <- substr(data[i], start, end)
  }
  
  colnames(df) <- varname
  return(df)
}


#Create the reporters dataset
  
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
  for(i in seq_along(fbi_reporting)){
    incident_no[i, 2] <- count_incidents(incident_no[i, 1])
  }
  colnames(incident_no) <- c("Number_Original_list", "Number_of_Incidents_Year")
  
  #Next section is for the creation of the fbi precincts dataframe
  
  reporting_df <- data.frame()
  
  for(i in seq_along(fbi_reporting)){
    reporting_df[i, 1] <- i
  }
  
  #State code variable
  reporting_df[, 1] <- read_var(fbi_reporting, "State_Code", 3, 4)
  
  colnames(reporting_df) [1] <- "State_Code"
  
  #State Abreviation Variable
  reporting_df[, 2] <- read_var(fbi_reporting, "State_Abr", 5, 6)
  
  #Country Region variable
  reporting_df[, 3] <- read_var(fbi_reporting, "Country_Region", 65, 65)
  
  for(i in seq_along(fbi_reporting)){
    ifelse(reporting_df[i, 3] == "1", reporting_df[i, 3] <- "NorthEast", 
           ifelse(reporting_df[i, 3] == "2", reporting_df[i, 3] <- "NorthCentral", 
                  ifelse(reporting_df[i, 3] == "3", reporting_df[i, 3] <- "South", reporting_df[i, 3] <- "West")))
  }
  
  #Agency_Type Variable
  reporting_df[, 4] <- read_var(fbi_reporting, "Agency_Type", 66, 66)
  
  for(i in seq_along(fbi_reporting)){
    ifelse(reporting_df[i, 4] == "0", reporting_df[i, 4] <- "CoveredbyOther", 
           ifelse(reporting_df[i, 4] == "1", reporting_df[i, 4] <- "City", 
                  ifelse(reporting_df[i, 4] == "2", reporting_df[i, 4] <- "County", 
                         ifelse(reporting_df[i, 4] == "3", reporting_df[i, 4] <- "Uni/Col", reporting_df[i, 4] <- "StatePolice"))))
  }
  
  #Core_City Variable
  reporting_df[, 5] <- read_var(fbi_reporting, "Metro_Area", 67, 67)
  
  for(i in seq_along(fbi_reporting)){
    ifelse(reporting_df[i, 5] == "N", reporting_df[i, 5] <- 0, reporting_df[i, 5] <- 1)
  }
  
  #Date ORI was added var
  reporting_df[, 6] <- read_var(fbi_reporting, "Date_Added", 14, 21)
  
  reporting_df[, 6] <- ymd(reporting_df[, 6])
  
  #Date ORI went NIBRS
  reporting_df[, 7] <- read_var(fbi_reporting, "Date_NIBRS", 22, 29)
  
  reporting_df[, 7] <- ymd(reporting_df[, 7])
  
  #City Name
  reporting_df[, 8] <- read_var(fbi_reporting, "City_Name", 30, 59)
  
  #Pop_Group Codes variable
  reporting_df[, 9] <- read_var(fbi_reporting, "Pop_Group_Code", 62, 63)
  
  #Judicial District Code
  reporting_df[, 10] <- read_var(fbi_reporting, "Judicial_Dist_in_State", 81, 84)
  
  #Is Nibrs Active?
  for(i in seq_along(fbi_reporting)){
    ifelse(substr(fbi_reporting[i], 85, 85) == "A", reporting_df[i, 10] <- 1, reporting_df[i, 10] <- 0)
  }
  
  colnames(reporting_df)[10] <- "IsActiveNIBRS"
  
  #Current population covered
  reporting_df[, 11] <- read_var(fbi_reporting, "Current_Pop", 94, 100)

  
  #FIPS County Code
  reporting_df[, 12] <- read_var(fbi_reporting, "FIPS_Code", 256, 270)
  
  #UCR County Code
  reporting_df[, 13] <- read_var(fbi_reporting, "UCR_Code", 103, 105)
  
  #MSA Code
  reporting_df[, 14] <- read_var(fbi_reporting, "MSA_Code", 106, 108)
  
  #Last Population
  reporting_df[, 15] <- read_var(fbi_reporting, "Last_Population", 109, 117)
  
  #Master File Year
  reporting_df[, 16] <- read_var(fbi_reporting, "Master_File_Year", 214, 217)
  
  #Agency ID
  reporting_df[, 17] <- read_var(fbi_reporting, "Agency_ID", 5, 13)
  
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
  
  for(i in seq_along(fbi_incidents)){
    incidents_df[i, 1] <- i
  }
  
  #State Code
  incidents_df[, 1] <- read_var(fbi_incidents, "State_Code", 3, 4)
  
  colnames(incidents_df) [1] <- "State_Code"
  
  #Agency ID
  incidents_df[, 2] <- read_var(fbi_incidents, "Agency_ID", 5, 13)
  
  #Incident Date
  incidents_df[, 3] <- read_var(fbi_incidents, "Incident_Date", 26, 33)
  
  incidents_df[, 3] <- ymd(incidents_df[, 3])
  
  #Quarter
  incidents_df[, 4] <- read_var(fbi_incidents, "Quarter", 35, 35)
  
  #Number of Victims
  incidents_df[, 5] <- read_var(fbi_incidents, "Victims", 36, 38)
  
  incidents_df[, 5] <- as.integer(incidents_df[, 5])
  
  #Offenders number
  incidents_df[, 6] <- read_var(fbi_incidents, "Offenders", 39, 40)
  
  incidents_df[, 6] <- as.integer(incidents_df[, 6])
  
  #Offender's Race
  incidents_df[, 7] <- read_var(fbi_incidents, "Offenders_Race", 41, 41)
  
  #UCR Offense Code
  incidents_df[, 8] <- read_var(fbi_incidents, "UCR_Code", 42, 44)
  
  #Location
  incidents_df[, 9] <- read_var(fbi_incidents, "Location_Code", 48, 49)
  
  #Bias Motivation
  incidents_df[, 10] <- read_var(fbi_incidents, "Bias_Motivation", 50, 51)
  
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
  
  incidents_df[, 12] <- read_var(fbi_incidents, "Victim_Type", 52, 59)


#Join

incidents_full <- rbind(incidents_df_2011, incidents_df_2012, incidents_df_2013)
reporting_full <- rbind(reporting_df_2011, reporting_df_2012, reporting_df_2013)

write.csv(incidents_full, "hatecrime_incidents_2011to13.csv")
write.csv(reporting_full, "hatecrime_reporters_2011to13.csv")