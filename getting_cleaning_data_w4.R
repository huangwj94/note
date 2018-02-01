#### editing text variables

## fixing character vectors
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

tolower(names(cameraData)) ## make all names lowercase

splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]

## quick a side
mylist <- list(letter = c("A","B","C"),
               numbers = 1:3,
               matrix(1:25,ncol = 5))
head(mylist)
splitNames[[6]][1]

firstElement <- function(x) {x[1]}
sapply(splitNames,firstElement)

## peer review data, already download
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")

names(reviews)

sub("_","",names(reviews)) ## remove "_", but only the first one

testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName) ## replace all "_" with ""

grep("Alameda", cameraData$intersection) #find the rows that has "alamenda" in cameradata$intersection
table(grepl("Alameda", cameraData$intersection)) # generate logical vector
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),] #subset the table
grep("Alameda", cameraData$intersection,value = TRUE) # show where "alameda" is
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))

library(stringr)
nchar("Jeffery Leek")
substr("Jeffrey Leek",1,7) ## first to seventh letters
paste("Jeffrey","Leek")
paste("Jeffrey","Leek", sep = ".")
paste0("Jeffrey","Leek") # no separation
str_trim("Jeffrey     ")


#### regular expressions
# ^  = the beginning of a line ^i think
# $  = the end of a line , morning$
# [Bb] [Uu] [Ss] [Hh] =bush, Bush, bushes, BUSH
## conmibination of the above
# ^[Ii] am
# ^[0-9] [a-zA-Z] range of character
# [^?.]$

# "." refers to any character
# eg. 9.11 = 9-11, 9/11, 9:11

# "|" refers to "or"
# eg. flood|fire = flood, fire, floods; floods|fire|earthquake

# combination
# ^[Gg]ood|[Bb]ad , "bad" doesn't have to be at beginning
# ^([Gg]ood|[Bb]ad), "good" "bad" all have to be at beginning

# "?" refer to optional
# ^[Gg]eorge([Ww]\.)? [Bb]ush = george bush, George W. Bush
# "\." = the real dot, rather than the metacharater

# "*" = any number, including none, of the item
# "+" = at least one of the item
# eg. (.*) = (24,m,germany), ()
# eg. [0-9]+ (.*)[0-9]+  = 720, 2 or 3

# {} refer to as interval quantifiers
# eg. [Bb]ush( +[^ ]+ +){1,5} debate == bush(space)(word)(space)[1-5 times]debate
# eg.  +([a-zA-Z]+) +\1 +  , == night night (repetition)

# ^s(.*)s == start with s and end with s
# ^s(.*?)s$ == start with s and end with s

#### working with dates
d1=date()
d1
d2 = Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")
# %d = day, %a =abbr. weekday, %A = full weekday,
# %m = month, %b = abbr. month, %B = full month, 
# %y = 2digit year, %Y = 4 digit year
weekdays(d2)
months(d2)
julian(d2) # number of days since 1970-01-01

library(lubridate)
ymd("20171113")
mdy("11/13/2017")
dmy("13/11/2017")

ydm_hms("2011-08-03 10:15:54")
ydm_hms("2011-08-03 10:15:54", tz = "Pacific/Auckland")

x = dmy(c("01012013","02012013","31032013","30072013"))
wday(x[1])
wday(x[1], label=TRUE)

#### data resources
