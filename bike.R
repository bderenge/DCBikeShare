# import data
2017Q1.capitalbikeshare.tripdata` <- read.csv("~/R/dc bikeshare/2017Q1-capitalbikeshare-tripdata.csv")
bike <- `2017Q1.capitalbikeshare.tripdata`


sum(bike$Duration)
hist(bike$Duration)

table(bike$Member.type)


bike$dt <- date(as_datetime(bike$End.date))
#aggregations

#By dat2
library(tidyverse)


bike %>%
  group_by(End.date) %>%
  summarize(trips = tally(End.date))


date_agg <- bike %>% count(dt)
plot(x= date_agg$dt, y=date_agg$n)


ggplot(date_agg, aes(n)) + geom_histogram() + xlab("Daily Number of Rides")

ggplot(date_agg, aes(x = dt, y = n)) + geom_point() + geom_line()

#aggrgate by date and member type
table(bike$Member.type)

bike %>% count(Member.type)
date_mem <- bike %>% count(dt, Member.type)

#daily ride by member type
ggplot(date_mem, aes(x = dt, y = n , color = Member.type)) + geom_point() + geom_line()
#how many bikes
n(unique(bike$Bike.number))
n_distinct(bike$Bike.number)



d <- as.vector(date_agg$n)

#CalendR plot
calendR(year = 2017,
        #start = "S",
        start_date = "2017-01-01", # Custom start date
        end_date = "2017-04-01",
        #special.days = 1:91,
        special.days = rank(d),
        gradient = TRUE,      # Set gradient = TRUE to create the heatmap
        special.col = rgb(1, 0, 1, alpha = 0.6), # Color of the gradient for the highest value
        low.col = "white")   


## most/least poplar locations
top_loc_end <- bike %>% count(End.station) %>% arrange(desc(n))
head(top_loc_end,10)

top_loc_start <- bike %>% count(Start.station) %>% arrange(desc(n))
head(top_loc_start,10)
