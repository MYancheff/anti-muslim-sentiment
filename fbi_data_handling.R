test <- readLines(file("C:\\Users\\tdounias\\Downloads\\HC 2013 (1)\\HC 2013.txt", open = "r"), skipNul = TRUE)

file.choose()

head(test)

?readLines()
#12 spaces ignored

new_vec <- vector()
j <- 1

for(i in seq_along(test)){
  if(substr(test[i], 1, 1) == "B"){
    new_vec[j] <- test[i]
    j <- j + 1
  }
}

#if("Z" %in% test[i][])

#use substr function or stringr in tidyverse

