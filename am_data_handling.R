library(xlsx)
library(tidyverse)

neg_quotes <- read.xlsx2("C:\\Users\\tdounias\\Desktop\\Reed College\\Spring 2017\\MATH 241\\Repositories\\anti-muslim_rhetoric\\data\\GNI-HGTRP-Negative_Quotations.xls",
               sheetIndex = 1, 
               as.data.frame = TRUE)


viz_quotes_1 <- neg_quotes %>%
  mutate(count = 1) %>%
  group_by(Publication) %>%
  summarize(total_quotes = sum(count)) %>%
  arrange(desc(total_quotes))

viz_quotes_2 <- neg_quotes %>%
  mutate(count = 1) %>%
  unite(Name, First.Name, Middle.Name, Last.Name, sep = " ") %>%
  group_by(Name) %>%
  summarize(total_quotes = sum(count)) %>%
  arrange(desc(total_quotes))

neg_quotes$Publication <- as.character(neg_quotes$Publication) 

neg_quotes$Publication[neg_quotes$Publication %in% c("Mew York Post", "New Yor Post")] <- "New York Post"

tp_chars <- c("ThinkPogress", "ThinkPorgress", "ThinkPrgress", "ThinkProgess", "ThinkProgress", "ThnikProgress") 

neg_quotes$Publication[neg_quotes$Publication %in% tp_chars] <- "Think Progress"

neg_quotes$Publication[neg_quotes$Publication %in% c("TMP", "TPM")] <- "Talking Points Memo"

neg_quotes$Publication[neg_quotes$Publication == "The Hiil"] <- "The Hill"

neg_quotes$Publication[neg_quotes$Publication == "Politco"] <- "Politico"

neg_quotes$First.Name[neg_quotes$First.Name == "Amdrew"] <- "Andrew"

write.csv(neg_quotes, "Quotations_df_corrected.csv")

