x <- 1:5
y <- 6:10
z <- 11:15
#Exploring different ways to create matrices and dataframes
# Create a matrix where x, y and z are columns
cbind(x, y, z)
# Create a matrix where x, y and z are rows
rbind(x, y, z)

#Creating a matrix of integers from 1 to 10 with 5 rows and 2 columns
matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

#Creating a matrix of integers from 1 to 10 with 2 rows and 5 columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5)

#Now filling by row using the byrow argument
matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)

#Creating a dataframe of survey data

survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
str(survey)

# Create a dataframe of survey data WITHOUT factors
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)
str(survey)

library(help="datasets")

# head() shows the first few rows of the dataframe
head(ChickWeight)

# tail() shows the last few rows of the dataframe
tail(ChickWeight)

# View() opens the entire dataframe in a new window
View(ChickWeight)

# Print summary statistics of ChickWeight
summary(ChickWeight)

# Print additional information about ChickWeight to the console
str(ChickWeight)

#Using the names() function to access names of the columns of the dataframe
names(ToothGrowth)

# What is the mean of the weight column of ChickWeight?
mean(ChickWeight$weight)

# Give me a table of the supp column of ToothGrowth.
table(ToothGrowth$supp)

#Adding new columns to the dataframe
survey$sex <- c("m", "m", "f", "f", "m")
survey

#Changing column names
names(survey)[1] <- "participant.number"
survey

# Change the column name from age to years
names(survey)[names(survey) == "age"] <- "years"
survey

#Slicing dataframes to get the data

# Give me the rows 1-6 and column 1 of ChickWeight
ChickWeight[1:6, 1]

# Give me rows 1-3 and columns 1 and 3 of ToothGrowth
ToothGrowth[1:3, c(1,3)]

# Give me the 1st row (and all columns) of ToothGrowth
ToothGrowth[1, ]

# Give me the 2nd column (and all rows) of ToothGrowth
ToothGrowth[, 2]

#Slicing with logical vectors

# Create a new df with only the rows of ToothGrowth where supp equals VC
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

# Create a new df with only the rows of ToothGrowth where supp equals OJ and dose < 1

ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                  ToothGrowth$dose < 1, ]

#Slicing with subset function

# Get rows of ToothGrowth where len < 30 AND supp == "VC" AND dose >= 1
subset(x = ToothGrowth,
       subset = len < 30 &
         supp == "VC" &
         dose >= 1)

# Get rows of ToothGrowth where len < 30 AND supp == "VC", but only return the len and dose columns
subset(x = ToothGrowth,
       subset = len < 30 &
         supp == "VC",
       select = c(len,dose))

#Using with() function 

health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))
with(health, height / weight ^ 2)

#Exercise 8.7

library(yarrr)

#Creating a data frame using the given data using strings as factors set to FALSE
pirate.test <- data.frame("Name" = c("Astrid","Lea","Sarina","Remon","Letizia",
                                     "Babice","Jonas","Wendy","Niveditha","Gioia"),
                          "Sex" = c("F","F","F","M","F","F","M","F","F","F"),
                          "Age" = c(30,
                                    25,
                                    25,
                                    29,
                                    22,
                                    22,
                                    35,
                                    19,
                                    32,
                                    21),
                          "Superhero" = c("Batman",
                                          "Superman",
                                          "Batman",
                                          "Spiderman",
                                          "Batman",
                                          "Antman",
                                          "Batman",
                                          "Superman",
                                          "Maggott",
                                          "Superman"),
                          "Tattoos" = c(11,
                                        15,
                                        12,
                                        5,
                                        65,
                                        3,
                                        9,
                                        13,
                                        900,
                                        0)
,stringsAsFactors = FALSE)

#Viewing the pirate.test dataframe to make sure the data is loaded correctly
View(pirate.test)

#Calculating the median age using the median function
median(pirate.test$Age)

#Calculating mean age of male and female pirates slicing dataframes 
mean(pirate.test$Age[pirate.test$Sex == "F"])
mean(pirate.test$Age[pirate.test$Sex == "M"])

#Calculating most number of tattoos owned by a male pirate using the max function and slicing of dataframes using logical operators
max(pirate.test$Tattoos[pirate.test$Sex == "M"])

#Calculating percent of pirates under the age of 32 who were female using the length function and slicing of dataframes

length(which(pirate.test$Age<32 & pirate.test$Sex == "F"))/length(which(pirate.test$Age<32))

#Calculating percent of pirates under the age of 32 who were female

length(which(pirate.test$Age<32 & pirate.test$Sex == "M"))/length(which(pirate.test$Age<32))

#Adding the new column tattoos.per.year which shows how many tattoos each pirate has for each year in their life using the mutate function
Pirate.new <- mutate(pirate.test,tattoos.per.year=Tattoos/Age)

#Calculating which pirate had the most number of tattoos per year using slicing of dataframe
Pirate.new$Name [Pirate.new$tattoos.per.year == max(Pirate.new$tattoos.per.year)]

#Names of female pirates whose favorite superhero is Superman using slicing of dataframe
Pirate.new$Name [Pirate.new$Superhero == "Superman" & Pirate.new$Sex == "F"]

#Calculating median number of tattoos of pirates over the age of 20 whose favorite superhero is Spiderman
#Creating a subset of the data called Pirate1
Pirate1 <- subset(x = Pirate.new,
       subset = Age > 20 &
         Superhero == "Spiderman")
#Using the median function
median(Pirate1$Tattoos)


