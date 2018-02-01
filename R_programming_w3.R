## loop function

# lapply
x <- list(a = 1:5,b = rnorm(10))
lapply(x,mean)$b

x <- 1:4
lapply(x,runif,min = 0, max = 10)

x <- list(a = matrix(1:4,2,2), b = matrix(1:6,3,2))
lapply(x,function(elt) elt[,1]) 
# the function goes away when lapply finish

# sapply 
x <- list(a = 1:5,b = rnorm(10), 
          c = rnorm(20,1), d = rnorm(100,5))
sapply(x,mean)

# apply
x <- matrix(rnorm(200),20,10)
apply(x,2,mean) # preserve columns, collapes all rows 计算每列的 mean
apply(x,1,sum) # preserve rows, collapes all columns 计算每行的sum
apply(x,1,quantile,probs = c(0.25,0.75))

a <- array(rnorm(2*2*10), c(2,2,10))
apply(a,c(1,2), mean) #reserve 2 dimension, collapes the third
rowMeans(a,dims = 2)

# mapply
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
mapply(rep,1:4,4:1) # the same as previous one

# vectorizing a function
noise <- function(n, mean, sd) {
    rnorm(n, mean, sd)
        }
noise(5,1,2)
noise(1:5, 1:5, 2) # the result is not what we what
mapply(noise,1:5,1:5,2) # that's correct

# tapply
x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)

# split
split(x,f)
lapply(split(x,f), mean)

# split the data according to month（类似数据透视表）
s <- split(airquality,airquality$Month) 
# 根据月份，对三列数据分别求平均（类似数据透视表）
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
# 由于有NA，在函数中声明将NA移除
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")],
                              na.rm = TRUE))

# splitting on more than one level
x <- rnorm(10)
f1 <- gl(2,5)
f2 <-gl(5,2)
interaction(f1,f2)
split(x, list(f1,f2)) #有的里面为空
split(x, list(f1,f2),drop = FALSE) # 去掉为空的

# debugging
printmessage <- function(x) {
    if(x > 0)
        print("x is greater than zero")
    else
        print("x is less than or equal to zero")
    invisible(x) # will return the function but will not auto printing
    # most of time print function will return the content
    }

printmessage2 <- function(x) {
    if(is.na(x))
        print("x is a missing value!")
    else if (x > 0)
        print("x is greater than zero")
    else
        print("x is less than or equal to zero")
     invisible(x) # will return the function but will not auto printing
    # most of time print function will return the content
}

# debugging tools
# traceback
mean(k)
traceback() # have to call right after the error

lm(k-p) # error is many levels deep

options(error = recover)
read.csv("nosuchfile")