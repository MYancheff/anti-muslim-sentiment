full_fbi <- readLines(file("C:\\Users\\tdounias\\Downloads\\HC 2013 (1)\\HC 2013.txt", open = "r"), skipNul = TRUE)
library(tidyverse)
library(lubridate)

trim.trailing <- function (x) sub("\\s+$", "", x)

fbi_reporting <- vector()
fbi_incidents <- vector()
j <- 1
z <- 1

#creates vector with only reporting precincts
for(i in seq_along(full_fbi)){
  if(substr(full_fbi[i], 1, 1) == "B" && substr(full_fbi[i], 218, 225) != "        "){
    fbi_reporting[j] <- full_fbi[i]
    j <- j + 1
  }
  if(substr(full_fbi[i], 1, 1) == "I"){
  fbi_incidents[z] <- full_fbi[i]
  z <- z + 1
  }
}

#Next section is for the creation of the fbi precincts dataframe

reporting_df <- data.frame()
df_row_count <- 1

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
  reporting_df[i, 11] <- substr(fbi_reporting[i], 94, 100)
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
