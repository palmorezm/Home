
# Value at current time
# Value after first boost
# Cumulative values after boost
x <- rbinom(1:100, 10, (1/6))
plot(x, main= "Binomial")
x <- rgeom(1:100, (1/6))
plot(x, main= "Geometric")
x <- rpois(1:100, lambda = (1/6))
plot(x, main= "Poisson")
x <- runif(1:100, min = 1, max = 6)
plot(x, main= "Uniform")
x <- rexp(1:100, rate = 1)
plot(x, main= "Exponential")
x <- rnorm(1:100, mean = 3, sd = 1)
plot(x, main= "Normal")
