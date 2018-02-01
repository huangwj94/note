## getting_cleaning_data_w3

## sub setting and sorting
set.seed(12345)
X <- data.frame("var1"= sample(1:5),"var2"=sample(6:10),
                "var3"=sample(11:15))
X <-X[sample(1:5),]
X$var2[c(1,3)] = NA
X

X[,1]
X[,"var1"]
X[1:2,"var2"]

X[(X$var1 <= 3 & X$var3>11), ]

X[(X$var1 <= 3 | X$var3 > 15), ]

X[which(X$var2 >8 ),]


sort(X$var1)

sort(X$var1, decreasing = TRUE)
sort(X$var2,na.last = TRUE)

X[order(X$var1),]
X[order(X$var1,X$var3),]

library(plyr)

arrange(X,var1) ## increasing order of var1
arrange(X,desc(var1)) ## decreasing order of var1

X$var4 <- rnorm(5)
X

Y <- cbind(X,rnorm(5))
Y

## summarizing Data
if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL,destfile = "./data/restaurant.csv",method = "curl")
restData <- read.csv("./data/restaurant.csv")

head(restData, n = 3) ## to see the first three records of the data
tail(restData, n = 3)
summary(restData)
str(restData)

quantile(restData$councilDistrict,na.rm = TRUE)
quantile(restData$councilDistrict,probs = c(0.5,0.75,0.9))

table(restData$zipCode,useNA = "ifany")
table(restData$councilDistrict,restData$zipCode)

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

table(restData %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))

restData[restData$zipCode %in% c("21212","21213"),]

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt

warpbreaks$replicate <- rep(1:9,len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units = "Mb")




## create new variables

###already downloaded, called restdata
if(!file.exists("./data")){dir.create("/data")}
fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL,destfile = ".data/restaurants.csv",method = "curl")
restData <- read.csv("./data/restaurant.csv")
##----------

# creating sequences
s1 <- seq(1,10,by=2)
s1
s2 <- seq(1,10,length = 3)
s2
x <- c(1,3,8,25,100)
seq(along = x)

restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
table(restData$nearMe)

# creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE,FALSE)
table(restData$zipWrong,restData$zipCode < 0)

# creating categorical variables
restData$zipGroup = cut(restData$zipCode,breaks = quantile(restData$zipCode))
table(restData$zipGroup)

table(restData$zipGroup,restData$zipCode)

## easier cutting, need to download first
library(Hmisc)

# creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes","no"),size=10, replace = TRUE)
yesnofac =  factor(yesno,levels = c("yes","no"))
relevel(yesnofac,ref = "yes")
as.numeric(yesnofac)

## cutting produces factor variables,easy way
library(Hmisc) ## need installation
restData$zipGroup = cut2(restData$zipCode,g=4)
table(restData$zipGroup)

## using the mutate function 
library(Hmisc)
library(plyr)
restData2 = mutate(restData,zipGroup = cut2(zipCode,g=4))
table(restData2$zipGroup)

#### reshaping data
library(reshape2)
head(mtcars)

# melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"),
                measure.vars = c("mpg","hp"))
carMelt
# casting data frames
cylData <- dcast(carMelt, cyl ~ variable) ## ---wrong?
cylData <- dcast(carMelt, cyl ~ variable,mean) # its working
cylData

# averaging values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns


sprCount = lapply (spIns,sum)
sprCount

unlist(sprCount)
sapply(spIns, sum)

ddply(InsectSprays,.(spray),summarize,sum=sum(count))

# the length is the same as the original one
spraySums <-ddply(InsectSprays,.(spray),
                  summarize,sum=ave(count,FUN = sum))
dim(spraySums)
head(spraySums)




#### managing data frames with dplyr- intro
#### basic tools
library(dplyr)
chicago <- readRDS("chicago.rds") ## error? can't download
dim(chicago)
names(chicago)
## see the head of "chicago"from 'city'  to 'dptp'
head(select(chicago,city:dptp)) 
## see the head of "chicago" except the varianle from 'city'  to 'dptp'
head(select(chicago,-(city:dptp)))
##  if don't use "select" language, the equivalent way is 
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[,-(i:j)])
## filter the recored where pm25 > 30
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)
## reorder the data according to the date
chicago <- arrange(chicago,date)
head(chicago) # the early date is at head
tail(chicago) # the late date is at tail
## order the data according to the descending date
chicago <- arrange(chicago, desc(date))

## rename the variable, others remain unchanged
chicago <- rename(chicago, pm25=pm25mean2, dewpoint=dptp) 

## calculate the distance from the mean ->sigma
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = TRUE))
head(select(chicago,pm25,pm25detrend))

## 
chicago <- mutate(chigago,
                  tempcat = factor(1*(tmpd>80), 
                                           labels = c("cold","hot")))
hotcold <- group_by(chicago,tempcat)
summarize(hotcold, pm25=mean(pm25),o3=max(o3tmean2),
          no2 = median(no2tmean2))
summarize(hotcold, pm25=mean(pm25, na.rm = TRUE),
          o3=max(o3tmean2),
          no2 = median(no2tmean2))
chicago <- mutate(chicago,year = as.POSIXlt(date)$year+1990)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25,na.rm = TRUE), 
          o3 = max(o3tmean2),no2 = median(no2tmean2))

chicago %>% 
    mutate(month = as.POSIXlt(date)$mon+1) %>% 
    group_by(month) %>% 
    summarize(pm25 = mean(pm25, na.rm = TRUE),
              o3 = max(o3tmean2), 
              no2 = median(no2tmean2))


##### merging data
if(!file.exists("./data")){dir.create("./data")}
## the following two URL is broken
## fileURL1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
## fileURL2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
## the URL provided by students
fileURL1 = "http://www.sharecsv.com/dl/e70e9c289adc4b87c900fdf69093f996/reviews.csv"
fileURL2 = "http://www.sharecsv.com/dl/0863fd2414355555be0260f46dbe937b/solutions.csv"
download.file(fileURL1,destfile = "./data/reviews.csv", mode = "wb") 
download.file(fileURL2,destfile = "./data/solutions.csv", mode = "wb") 
reviews = read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2) ## preview the head
head(solutions,2)

## merging data
names(reviews)
names(solutions)
mergeDATA = merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
head(mergeDATA,5)
mergeDATA2 = merge(reviews, solutions, all = TRUE)
head(mergeDATA2,5)

## using join in the plyr package,
# useful when the id is the same, and variables are in many datafram
df1 = data.frame(id = sample(1:10), x=rnorm(10))
df2 = data.frame(id = sample(1:10), y=rnorm(10))
df3 = data.frame(id = sample(1:10), z=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)


