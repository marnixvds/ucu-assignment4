library('tidyverse')
library(dplyr)
library('maps')
#Read in and check out the data
temp <- read.csv('surfacetemp.csv')
summary(temp)
#How may cities are we taling about?
unique(temp$city)
#So 81 cities in the dataset

#Are the dates correctly formatted?
temp$dt[0]
#Factor, so no! Let's format
temp$dt #How is it formatted
as.Date(temp$dt, '%Y-%m-%d') #Checkout before doing definitive operation
temp$dt <- as.Date(temp$dt, '%Y-%m-%d')

#Are the average temperatures correctly fomatted?
temp$AverageTemperature[0] #Yes

#Filter for measurements of interest, with all temperatures from the year 2000 of cities that are bigger than 1M.
temp.ofinterest <- temp %>% filter(dt >= '2000-01-01' & dt < '2001-01-01' & pop_2017 > 1000000)

#Create a new column that combines city and country, which we can use later on to select
temp.ofinterest <- temp.ofinterest %>% mutate(citycountry = format(paste(city, country)))

#Calculate average temperatures over the year in a new frame, and label the column
temp.ofinterest.percity <- temp.ofinterest %>% group_by(citycountry) %>% summarize(mean(AverageTemperature))
temp.ofinterest.percity <- rename(temp.ofinterest.percity, 'temp2000' = 'mean(AverageTemperature)')

#Now we need to add the lng, lat and population data.
#These columns are have many many duplicates per city, so we need to remove all these duplicates.
temp.reduced <- unique(temp.ofinterest[,c(1, 6:9)])

#Merge the two datasets
temp.plot <- merge(temp.ofinterest.percity, temp.reduced, by='citycountry')

#Now make a plot that maps the temperature data on top of a world map
ggplot(data = temp.plot) +
  geom_polygon(data = map_data('world'), mapping = aes(x = long, y = lat, group=group), fill = NA, colour='black') +
  geom_point(mapping = aes(x=lng, y=lat, color=temp2000, size=pop_2017)) +
  labs(x = "Longitude", y = "Latitude", color = "Temperature [°C]\n", size = "Population")

