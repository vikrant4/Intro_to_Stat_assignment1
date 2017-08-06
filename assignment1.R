library(dplyr)

asylum <- read.csv(file = "time_series.csv")
asylum$Value <- as.integer(asylum$Value)

#Grouping the data based on Origin and Year
asylum.origin <- asylum %>% group_by(Year, Origin)

#Adding all the population values
asylum.origin <- asylum.origin %>% summarise(Value = sum(Value))

# Taking the top 5 values for each year
asylum.sort <- asylum.origin %>% filter(Value >= tail(sort(Value), 5))

# Filtering out Countries which are known to have had longstanding crises
asylum.sort.filter1 <- asylum.sort %>% filter(Origin %in% c( "Dem. Rep. of the Congo", "Iraq", "Somalia", "Afghanistan", "Iran (Islamic Rep. of)", "Syrian Arab Rep.") & Year > 1990)

write.csv(asylum.sort.filter1, "cleaned.csv")
