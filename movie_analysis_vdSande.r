library('tidyverse')

#Read in and check out the data
movies <- read.csv('movies.csv')
summary(movies)
#Interesting findings:
#Date doesn't seem to be in the right formatting, which is probably necessary for putting it on the x-axis.
#Genres are in dictionaries, which requires formatting for it to be usable in the graph
movies$release_date[0] #That's right, date needs to be converted.

#Formatting dates
movies$release_date #How is it formatted
as.Date(movies$release_date, '%Y-%m-%d') #Checkout before doing definitive operation
movies$release_date <- as.Date(movies$release_date, '%Y-%m-%d')

#Convert the budget data from factor to numerical.
movies$budget <- as.numeric(as.character(movies$budget))
#Filter out the movies for which a budget was specified
movies.ofinterest <- movies %>% filter(budget > 10000 & budget < 3e+08 & release_date > '1940-01-01' & vote_count > 20)
ggplot(data = movies.ofinterest) +
  geom_point(mapping = aes(x=release_date, y=budget, color=vote_average)) +
  labs(x = "Release Date", y = "Budget [$]", color = "Average Vote\n")
