##  getting & cleaning data

###### reading mySQL data
library(DBI)
library(RMySQL)
ucscDb <- dbConnect(MySQL(),user="genome",
                    host ="genome-mysql.cse.ucsc.edu" )
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb) ## close connection


hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                    host ="genome-mysql.cse.ucsc.edu" )
allTable <- dbListTables(hg19)
length(allTable)
allTable[1:5]

dbListFields(hg19,"affyU133Plus2") # list all column names
dbGetQuery(hg19,"select count(*) from affyU133Plus2") # MySQL command

affyData <- dbReadTable(hg19,"affyU133Plus2") # read data from SQL
head(affyData)

# send query to query to the db but not get the data right away
# the query is saved at remote
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
# connect to the result of data from remote
affyMis <- fetch(query)
# get quantiles
quantile(affyMis$misMatches)
# connect to the result of data from remote and get part of it
affyMisSmall <- fetch(query, n=10)
dbClearResult(query) #clear the query
dim(affyMisSmall) # to see the dimension of the subdb

# close the connection !!! as soon as the query is over
dbDisconnect(hg19)


##### reading from HDF5
## h5 is similar to a storage to store datasets
# R HDF5 package
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
create = h5createFile("example.h5")
create
create = h5createGroup("example.h5","foo")
create = h5createGroup("example.h5","baa")
create = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

## write dataset to h5
A = matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")

B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")

h5ls("example.h5")

df = data.frame(1L:5L,seq(0,1,length.out = 5),
                c("ab","cde","fghi","a","s"),
                stringsAsFactors = FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

# reading data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA

# read and write chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")

##### reading from the web
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)

xpathSApply(html,"//title",xmlValue)
xpathSApply(html,"//td[@id='col-citedby']",xmlValue)


# get from httr package
library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)

# accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1 # cannot get through because no authorization

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd")) 
            # user="user", pw="passwd"
pg2
names(pg2)

google = handle("http://google.com")
pg1 = GET(handle = google, path="/")
pg2 = GET(handle = google, path="search")

##### reading from AIPs
# 全程懵逼？有必要回去看

##### reading from other sources
