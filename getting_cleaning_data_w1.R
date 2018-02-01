# checking for and creating directories
if (!file.exists("data")) {
    dir.create("data")
}

# downloading data from the website
fileURL <- "https:...."
download.file(fileURL, destfile = "....", method = "curl") 
    #has to set method if URL begins with https
downloaddate <- date() # record the download date

# reading local files
cameraData <- read.table("...csv",sep = ",", header = TRUE)
cameraData <- read.csv("...csv",sep = ",", header = TRUE)

# reading excel files
library(xlsx)
colIndex <- 2:3
rowIndex <- 1:4
cameraData <- read.xlsx("....", sheetIndex = 1, 
                        colIndex = colIndex, 
                        rowIndex = rowIndex)



library(XML)
fileURL <- getURL("https://www.w3schools.com/xml/simple.xml")
doc <- xmlTreeParse(fileURL, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)


fileURl <- getURL("http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens")
doc <- htmlTreeParse(fileURl,useInternal =  TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
team <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)


# reading JSON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
names(jsonData$owner$id)


myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)


# data.table pachage
library(data.table)
DF = data.frame(x=rnorm(9),y =rep(c("a","b","c"),each=3),z=rnorm(9))

DT = data.table(x=rnorm(9),y =rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)

tables()
DT[2,]
DT[c(2,3)]
DT[,c(2,3)]


{
    x = 1
    y = 2
}
k={print(10);5}


DT[,list(mean(x),sum(z))]
DT[,table(y)]
DT2 <- DT[,w:=z^2] # add new variable to the table

DT[,m:={tmp <- (x+z);log2(tmp+5)}]

DT[,a:=x>0]
DT[,B:=mean(x+w),by=a]

set.seed(123);
DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
DT[, .N, by=x]

DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT,x)
DT['a']

DT1 <- data.table(x=c('a','b','b','dt1'),y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x); setkey(DT2, x)
merge(DT1,DT2)

big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df,file=file,row.names = FALSE, col.names = TRUE, sep="\t",quote = FALSE)
system.time(read.table(file, header=TRUE,sep="\t"))


