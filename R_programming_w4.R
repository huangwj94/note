## the string function

# str: tell you the feature of the object
str(str)
str(lm)
str(ls)
x <- rnorm(100,2,100)
summary(x)
str(x)
f <- gl(40,10)
str(f)
summary(f)
library(datasets)
head(airquality)
str(airquality)
m <- matrix(rnorm(100),10,10)
str(m)
m[,1]

# str after split
s <- split(airquality,airquality$Month)
str(s)


## simulation - generating random numbers
x <- 10
d <- dnorm(x, mean = 0, sd = 1, log = FALSE)
plot(d)
p <- pnorm(x, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
plot(p)
q <- qnorm(x, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
plot(q)

r <- rnorm(x, mean = 0, sd = 1)
plot(r)

# no.1
set.seed(1)
rnorm(5)
# no.2
rnorm(5) ## different from the first one
# no.3
set.seed(1)
rnorm(5) ## same as the no.1

# pois: 泊松分布
rpois(10,1)
rpois(10,2)
rpois(10,20)

ppois(2,2)
ppois(4,2)
ppois(6,2)


## simulation - simulating a linear model

# random
set.seed(20)
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5 +2 * x + e
summary(y)
plot(x,y)

# binary
set.seed(10)
x <- rbinom(100,1,0.5)
e <- rnorm(100,0,2)
y <- 0.5 +2 * x +e
summary(y)
plot(x,y)

# poisson model
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100,exp(log.mu))
summary(y)
plot(x,y)

## simulations - random sampling
set.seed(1)
sample(1:10,4)
sample(1:10,4)
sample(letters, 5)
sample(1:10) # permutation 排列
sample(1:10)
sample(1:10, replace = TRUE) ## samole with replacement

## R profiler (part1)
# elapsed time > user time
system.time(readLines("http://www.jhsph.edu"))
# elapsed time < user time
hilbert <- function(n) {
    i <- 1:n
    1/outer(i - 1,i,"+")
}
system.time(svd(x))

system.time({
    n <- 1000
    r <- numeric(n)
    for (i in 1:n){
        x <- rnorm(n)
        r[i] <- mean(x)
    }
})

## R profiler (part 2)
Rprof()
summaryRprof()
by.total # time on a specific function
$sample.interval
$sample.time
