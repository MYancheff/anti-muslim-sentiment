library(readxl)
library(tidyverse)

data <- read_excel("rethinkdata.xlsx")

colnames(data) <- as.character(unlist(data[1,]))
data = data[-1, ]
                             
new_data <- select(data, Date, Islamophobia)
new_rethink <- new_data %>% mutate (Year = year(mdy(Date)), Month = month (mdy(Date)))

fbi_data <- read.csv("hatecrime_incidents_2011to13.csv")
new_fbi <- select(fbi_data, Incident_Date, Anti_Muslim)
new_fbi <- filter(new_fbi, Anti_Muslim == "Y")
new_new <- new_fbi %>% mutate(Year = year(Incident_Date), Month = month(Incident_Date), count = 1) 

fbi_2011 <- filter(new_new, Year == "2011")
fbi_2011 <- aggregate(fbi_2011$count, by=list(Month=fbi_2011$Month), FUN=sum)

fbi_2012 <- filter(new_new, Year == "2012")
fbi_2012 <- aggregate(fbi_2012$count, by=list(Month=fbi_2012$Month), FUN=sum)

fbi_2013 <- filter(new_new, Year == "2013")
fbi_2013 <- aggregate(fbi_2013$count, by=list(Month=fbi_2013$Month), FUN=sum)

join_2011 <- fbi_2011 %>% inner_join(rethink_2011, by = c("Month" = "Month"))
join_2012 <- fbi_2012 %>% inner_join(rethink_2012, by = c("Month" = "Month"))
join_2013 <- fbi_2013 %>% inner_join(rethink_2013, by = c("Month" = "Month"))

join_2011$fbi <- join_2011$x.x
join_2011$media <- join_2011$x.y

join_2012$fbi <- join_2012$x.x
join_2012$media <- join_2012$x.y

join_2013$fbi <- join_2013$x.x
join_2013$media <- join_2013$x.y

join_2011$Month <- as.factor(join_2011$Month)
join_2012$Month <- as.factor(join_2012$Month)
join_2013$Month <- as.factor(join_2013$Month)

ggplot(data = join_2011, aes(media, fbi)) + geom_point()
ggplot(data = join_2011, aes(media, fbi)) + geom_point()
ggplot(data = join_2011, aes(media, fbi)) + geom_point()

summary(lm(join_2013$fbi ~ join_2013$media))
geom_density(join_2011, x = Month, y = fbi)

join_2011$fbi <- as.integer
new_rethink$Islamophobia <- as.integer(new_rethink$Islamophobia)
rethink_2011 <- filter(new_rethink, Year == "2011")
rethink_2011 <- aggregate(rethink_2011$Islamophobia, by=list(Month=rethink_2011$Month), FUN=sum)

rethink_2012 <- filter(new_rethink, Year == "2012")
rethink_2012 <- aggregate(rethink_2012$Islamophobia, by=list(Month=rethink_2012$Month), FUN=sum)

rethink_2013 <- filter(new_rethink, Year == "2013")
rethink_2013 <- aggregate(rethink_2013$Islamophobia, by=list(Month=rethink_2013$Month), FUN=sum)


ggplot(data = join_2011, aes(Month,fbi)) + geom_bar()


new_rethink %>% group_by(Year, Month) %>%
  summarize(Number_of_Incidents = sum(Islamophobia))


