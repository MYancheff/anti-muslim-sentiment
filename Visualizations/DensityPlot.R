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

new_join_month <- new_joined %>% mutate(Month = month(newdate), count = 1)

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

joined_data$Anti_Muslim <- as.integer(joined_data$Anti_Muslim)

ddply(joined_data,"Anti_Muslim",numcolwise(sum))

new_joined_data <- aggregate(Anti_Muslim~newdate,data=joined_data,FUN=sum) 

joined <- rethink %>% left_join(new_joined_data, by = c("newdate" = "newdate"))

new_join <- joined %>% mutate(Year = year(ymd(newdate)))
new_join <- filter(new_join, Year == "2011" | Year == "2012" | Year == "2013")

ggplot(data = new_join, aes(x=newdate, y=Islamophobia)) + geom_density()

new_new_join <- gather(new_join, key = type, value = count, Islamophobia, Anti_Muslim)


weeks <- new_new_join %>% mutate(week = (year(newdate) - year(min(newdate)))*52 + 
                 week(newdate) - week(min(newdate)),
               week2 = (as.numeric(newdate) %/% 7) - (as.numeric(min(newdate)) %/% 7)) %>%
  arrange(newdate)


ggplot(data = join_2011, aes(x=week, y=count, col=type), group=type) + geom_line() + scale_y_log10() 
ggplot(data = join_2011, aes(x=week, y=count, fill=type), group=type) + 
  geom_bar(stat = "identity", position = "identity") +
coord_flip() +
  theme_minimal() +
  labs(title = "Rate of Islamophobia in National Media 
       and the Rate of Anti-Muslim Hate Crimes 
       in the United States, 2011", x = "Week (1-52) of 2011", y = "Count") + 
  scale_fill_discrete(name="Legend")

ggplot(data = join_2012, aes(x=week, y=count, fill=type), group=type) + 
  geom_bar(stat = "identity", position = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Rate of Islamophobia in National Media 
       and the Rate of Anti-Muslim Hate Crimes 
       in the United States, 2012", x = "Week (1-52) of 2012", y = "Count") + 
  scale_fill_discrete(name="Legend")

ggplot(data = join_2011, aes(x=newdate, y=count, col=type, fill=type)) + geom_density(stat = "identity") 
  
ggplot(data = join_2011, aes(x=newdate, y=count, col=type, fill=type, alpha=.3)) + geom_density(stat = "identity")

join_2011$type <- as.factor(join_2011$type)

print(levels(join_2011$type))

join_2011$type = factor(join_2011$type,levels(join_2011$type)[c(2,1)])


join_2011 <- filter(weeks, Year == "2011")
join_2012 <- filter(weeks, Year == "2012")
join_2013 <- filter(weeks, Year == "2013")

join1_2011 <- filter(new_new_join, Year == "2011")
join1_2012 <- filter(new_new_join, Year == "2012")
join1_2013 <- filter(new_new_join, Year == "2013")

ggplot(data = join1_2011, aes(x=newdate, y=count, col=type)) + geom_line() +
  scale_x_date(date_labels = "%b %d") + xlab("") + ylab("Daily Views")

ggplot(data = join_2011, aes(x=weeks, y=count, fill=type), group=type) + geom_bar(stat = "identity", position = "identity") 


