full_fbi <- readLines(file("C:\\Users\\tdounias\\Downloads\\HC 2013 (1)\\HC 2013.txt", open = "r"), skipNul = TRUE)



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

#if("Z" %in% test[i][])

#use substr function or stringr in tidyverse

