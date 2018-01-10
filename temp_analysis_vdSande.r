library('tidyverse')

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
as.Date(movies$release_date, '%Y-%m-%d') #Checkout before doing definitive operation
movies$release_date <- as.Date(movies$release_date, '%Y-%m-%d')

ggplot(data = temp) + geom_point(mapping = aes(x=lng, y=lat, color=AverageTemperature))
