library(readxl)
library(tidyverse)

data <- read_excel("rethinkdata.xlsx")

colnames(data) <- as.character(unlist(data[1,]))
data = data[-1, ]

new_data <- select(data, Date, Islamophobia)
new_rethink <- new_data %>% mutate (Year = year(mdy(Date)), Month = month (mdy(Date)))

fbi_data <- read.csv("fbi.csv")
new_fbi <- select(fbi_data, Incident_Date, Anti_Muslim)
new_fbi <- filter(new_fbi, Anti_Muslim == "Y")
new_new <- new_fbi %>% mutate(Year = year(Incident_Date), Month = month(Incident_Date), count = 1) 


new_data$newdate <- strptime(as.character(new_data$Date), "%m/%d/%Y")

new_data <- new_data[c("newdate", "Islamophobia", "Date")]
rethink <- select(new_data, newdate, Islamophobia)

rethink$Islamophobia <- as.integer(rethink$Islamophobia)
rethink$newdate <- as.character(rethink$newdate)


new_fbi$Incident_Date <- as.character(new_fbi$Incident_Date)

joined <- rethink %>% left_join(new_fbi, by = c("newdate" = "Incident_Date"))

new_joined <- joined %>% mutate(Year = year(ymd(newdate)))
new_joined <- filter(new_joined, Year == "2011" | Year == "2012" | Year == "2013")

new_joined$Anti_Muslim <- as.character(new_joined$Anti_Muslim)

new_joined$Anti_Muslim[new_joined$Anti_Muslim == "Y"] <- "1"

new_joined[is.na(new_joined)] <- 0

joined_data <- select(new_joined, newdate, Islamophobia, Anti_Muslim)

