library(tidyverse)

#Learning the different types of read commands available in the tidyverse package

gapminder <- read_csv("MS Analytics/ANLY 506/Data/gapminder.csv")
read_csv("The first line of metadata
         The second line of metadata
         x,y,z
         1,2,3",skip=2)
read_csv("# A comment I want to skip
         x,y,z
         1,2,3",comment="#")
read_csv("1,2,3\n4,5,6",col_names=FALSE)
read_csv("1,2,3\n4,5,6",col_names=c("x","y","z"))
?read_fwf()

#11.2.2 exercises
## 1.read_delim() can be used to read files with | as delimiter.
## 2. Almost all arguments are common between read_csv and read_tsv. Other common arguments
## are col_names, na, locale.
##3.fwf_widths() and fwf_positions() are important arguments of read_fwf()

read_csv("a,b\n1,2,3\n4,5,6")
# As the first row only has 2 values, second and third row also need to have 3 values

read_csv("a,b,c\n1,2\n1,2,3,4")
# As the first row has 3 values, the third observation of the second and third row
# are skipped
read_csv("a,b\n\1")
# As the first row or header row has 2 values, the second row needs to have 2 values or one of the observations will be NA.

str(parse_logical(c("TRUE", "FALSE", "NA")))

str(parse_integer(c("1", "2", "3")))

str(parse_date(c("2010-01-01", "1979-10-14")))

parse_integer(c("1", "231", ".", "456"), na = ".")

x <- parse_integer(c("123", "345", "abc", "123.45"))

parse_double("1.23")

parse_double("1,23", locale = locale(decimal_mark = ","))

parse_number("$123,456,789")

parse_number("123.456.789", locale = locale(grouping_mark = "."))

parse_number("123'456'789", locale = locale(grouping_mark = "'"))

fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit)

parse_datetime("2010-10-01T2010")
parse_datetime("20101010")
parse_date("2010-10-01")
library(hms)
parse_time("01:10 am")
parse_time("20:10:01")

#11.3.5 Exercises
# 1. Most important arguments to locale are decimal_mark, grouping_mark.

parse_number("123.456.789", locale = locale(grouping_mark = ".",decimal_mark="."))

#2. R throws an error the decimal and grouping mark must be different.
  parse_date("2010-10-01",locale=locale(date_format="%BC"))

#5. read_csv() reads comma delimited files, read_csv2() reads semicolon separated files

#Correct strung format to parse out given dates and times
d1 <- parse_date("January 1, 2010","%B %d, %Y")  
d2 <- parse_date("2015-Mar-07","%Y-%b-%d")
d3 <- parse_date("06-Jun-2017","%d-%b-%Y")
d4 <- parse_date(c("August 19 (2015)", "July 1 (2015)"),"%B %d (%Y)")
d5 <- parse_date("12/30/14","%m/%d/%y")
t1 <- parse_time("1705","%H%M")

