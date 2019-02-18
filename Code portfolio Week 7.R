library(nycflights13)
library(tidyverse)
library(dplyr)

#Filter function to filter records with month of 1 and day of 12 and store in jan12 dataframe
jan12 <- filter(flights, month == 1, day == 12)

#Filtering using the OR operator to flights departing in january or february

Jan.feb <- filter(flights, month == 1 | month == 2)

#Filtering flights with arrival and departure delay less than 5 hours
filter(flights, arr_delay <= 300, dep_delay <= 300)

View (flights)

#5.2.4 Exercises

#Filtering to flights with arrival delay of more than 2 hours
filter(flights, arr_delay >= 120)

#Filtering flights that flew to IAH or HOU
filter(flights, dest == "IAH" | dest == "HOU")

#Filtering flights operated by United, American or Delta
filter(flights, carrier == "UA" | carrier == "AA" | carrier == "DL")

#Filtering flights Departed in summer (July, August, and September)
filter(flights, month == 7 | month == 8 | month == 9)

#Filtering flights that arrived more than two hours late, but didn't leave late
filter(flights, arr_delay >= 120, dep_delay <= 0)

#Filtering flights that were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, arr_delay < 30, dep_delay >= 60)

#Filtering flights that departed between midnight and 6am
x1 <- filter(flights, dep_time >= 0000, dep_time <= 0600)
View (x1)

#between function is a shortcut for x >= left & x <= right.

#Counting number of flights with missing departure time
sum (is.na(flights$dep_time))

#5.3.1 Exercises
#using arrange() to sort all missing values to the start? (Hint: use is.na()).
names(flights)[colSums(is.na(flights)) >0]
flights %>% 
  arrange(desc(is.na(dep_time)),
          desc(is.na(dep_delay)),
          desc(is.na(arr_time)), 
          desc(is.na(arr_delay)),
          desc(is.na(tailnum)),
          desc(is.na(air_time)))

#Sort flights to find the most delayed flights. Find the flights that left earliest.

arrange(flights, desc(dep_delay))
arrange(flights, arr_delay)

#Sort flights to find the fastest flights and shortest flights
arrange(flights, air_time)

#Using the selct function

# Select columns by name
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
select(flights, year:day)

# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

# Using rename
rename(flights, tail_num = tailnumber)

#5.4.1 Exercises

#Selecting dep_time, dep_delay, arr_time, and arr_delay from flights.
select(flights,dep_time,dep_delay,arr_time,arr_delay)

#Including the name of a variable multiple times in a select() call
select(flights,dep_time,dep_time,arr_time,arr_delay)
#The variable only shows up once

select(flights, contains("TIME"))

#Adding new variables with mutate
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

#Using transmute to keep just the new columns
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

#5.5.2 exercises

#Creating a new column called airtime_calc as difference between arr time and dep time

flights_sml <- select(flights, 
                      year:day, 
                      ends_with("time"),
                      ends_with("delay"),
                      distance, 
                      air_time
)
flights_sml <- mutate(flights_sml,
       airtime_calc = arr_time - dep_time)
View (flights_sml)

#Comparing the difference it appears that the calculated airtime is different to the airtime given in the data

View (flights)
#Comparing dep_time, sched_dep_time, and dep_delay, we can observe that dep_delay is the difference between the sched_dep_time and dep_time

#Finding the 10  most delayed flights

flights_sml <- mutate(flights_sml,
                      rank=min_rank(desc(flights$arr_delay)))

arrange(flights_sml,rank)
View (flights_sml)


1:3 + 1:10
#1:3 is added to 1:10 in order. R throws an error saying longer object length is not a multiple of shorter object length.

#Using summarize and groupby to find mean delays by destination

by_dest <- group_by(flights, dest)
summarise(by_dest, delay = mean(arr_delay, na.rm = TRUE))

#Analyze mean departure delays by departing airport and distance using pipe operator

delays <- flights %>% 
  group_by(origin) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(dep_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20)



