# test script
library(testthat)

a1 = c(1, 2, 3, 4, 5)
a2 = c(NA, 0, -1, 5, 10)
a2_1 = c(0, -1, 5, 10)
a3 = c(-5, -4, 0, 1, 3, 7)
a4 = c(NA, NA, 3, 2, 8)
a4_1 = c(3, 2, 8)

# Tests for remove_missing
context("Tests for remove_missing")
expect_that(remove_missing(a1), equals(a1))
expect_that(remove_missing(a2), equals(a2_1))
expect_that(remove_missing(a3), equals(a3))
expect_that(remove_missing(a4), equals(a4_1))

# Tests for get_minimum
context("Tests for get_minimum")
expect_equal(get_minimum(a1, T), 1)
expect_equal(get_minimum(a2, F), as.double(NA))
expect_equal(get_minimum(a3, T), -5)
expect_equal(get_minimum(a4, T), 2)

# Tests for get_maximum
context("Tests for get_maximum")
expect_equal(get_maximum(a1, T), 5)
expect_equal(get_maximum(a2, T), 10)
expect_equal(get_maximum(a3, F), 7)
expect_equal(get_maximum(a4, T), 8)

# Tests for get_range
context("Tests for get_range")
expect_equal(get_range(a1, T), 4)
expect_equal(get_range(a2, T), 11)
expect_equal(get_range(a3, T), 12)
expect_equal(get_range(a4, T), 6)

# Tests for get_median
context("Tests for get_median")
expect_equal(get_median(a1, T), median(a1, T))
expect_equal(get_median(a2, T), median(a2, T))
expect_equal(get_median(a3, T), median(a3, T))
expect_equal(get_median(a4, T), median(a4, T))
expect_equal(get_median(a4, F), median(a4, F))

# Tests for get_average
context("Tests for get_average")
expect_equal(get_average(a1, T), mean(a1, na.rm = T))
expect_equal(get_average(a2, T), mean(a2, na.rm = T))
expect_equal(get_average(a3, T), mean(a3, na.rm = T))
expect_equal(get_average(a4, F), mean(a4, na.rm = F))

# Tests for get_stdev
context("Tests for get_stdev")
expect_equal(get_stdev(a1, T), sd(a1, T))
expect_equal(get_stdev(a2, F), sd(a2, F))
expect_equal(get_stdev(a3, T), sd(a3, T))
expect_equal(get_stdev(a4, T), sd(a4, T))

# Tests for get_quartile1
context("Tests for get_quartile1")
expect_equal(get_quartile1(a1, T), quantile(a1, .25, na.rm = T)[[1]])
expect_equal(get_quartile1(a2, T), quantile(a2, .25, na.rm = T)[[1]])
expect_equal(get_quartile1(a3, T), quantile(a3, .25, na.rm = T)[[1]])
expect_equal(get_quartile1(a4, T), quantile(a4, .25, na.rm = T)[[1]])

# Tests for get_quartile3
context("Tests for get_quartile3")
expect_equal(get_quartile3(a1, T), quantile(a1, .75, na.rm = T)[[1]])
expect_equal(get_quartile3(a2, T), quantile(a2, .75, na.rm = T)[[1]])
expect_equal(get_quartile3(a3, T), quantile(a3, .75, na.rm = T)[[1]])
expect_equal(get_quartile3(a4, T), quantile(a4, .75, na.rm = T)[[1]])

# Tests for get_percentile10
context("Tests for get_percentile10")
expect_equal(get_percentile10(a1, T), quantile(a1, .1, na.rm = T)[[1]])
expect_equal(get_percentile10(a2, T), quantile(a2, .1, na.rm = T)[[1]])
expect_equal(get_percentile10(a3, T), quantile(a3, .1, na.rm = T)[[1]])
expect_equal(get_percentile10(a4, T), quantile(a4, .1, na.rm = T)[[1]])

# Tests for get_percentile90
context("Tests for get_percentile90")
expect_equal(get_percentile90(a1, T), quantile(a1, .9, na.rm = T)[[1]])
expect_equal(get_percentile90(a2, T), quantile(a2, .9, na.rm = T)[[1]])
expect_equal(get_percentile90(a3, T), quantile(a3, .9, na.rm = T)[[1]])
expect_equal(get_percentile90(a4, T), quantile(a4, .9, na.rm = T)[[1]])

# Tests for count_missing
context("Tests for count_missing")
expect_equal(count_missing(a1), 0)
expect_equal(count_missing(a2), 1)
expect_equal(count_missing(a3), 0)
expect_equal(count_missing(a4), 2)

# Tests for summary_stats
context("Tests for summary_stats")
a1_s = list(
  minimum = min(a1, na.rm = T),
  percent10 = quantile(a1, .1, na.rm = T)[[1]],
  quartile1 = quantile(a1, .25, na.rm = T)[[1]],
  median = median(a1, na.rm = T),
  mean = mean(a1, na.rm = T),
  quartile3 = quantile(a1, .75, na.rm = T)[[1]],
  percent90 = quantile(a1, .9, na.rm = T)[[1]],
  maximum = max(a1, na.rm = T),
  range = 4,
  stdev = sd(a1, na.rm = T),
  missing = 0
)
expect_equal(summary_stats(a1), a1_s)

a2_s = list(
  minimum = min(v2, na.rm = T),
  percent10 = quantile(a2, .1, na.rm = T)[[1]],
  quartile1 = quantile(a2, .25, na.rm = T)[[1]],
  median = median(a2, na.rm = T),
  mean = mean(a2, na.rm = T),
  quartile3 = quantile(a2, .75, na.rm = T)[[1]],
  percent90 = quantile(a2, .9, na.rm = T)[[1]],
  maximum = max(a2, na.rm = T),
  range = 11,
  stdev = sd(a2, na.rm = T),
  missing = 1
)
expect_equal(summary_stats(a2), a2_s)

a3_s = list(
  minimum = min(a3, na.rm = T),
  percent10 = quantile(a3, .1, na.rm = T)[[1]],
  quartile1 = quantile(a3, .25, na.rm = T)[[1]],
  median = median(a3, na.rm = T),
  mean = mean(a3, na.rm = T),
  quartile3 = quantile(a3, .75, na.rm = T)[[1]],
  percent90 = quantile(a3, .9, na.rm = T)[[1]],
  maximum = max(a3, na.rm = T),
  range = 12,
  stdev = sd(a3, na.rm = T),
  missing = 0
)
expect_equal(summary_stats(a3), a3_s)

a4_s = list(
  minimum = min(a4, na.rm = T),
  percent10 = quantile(a4, .1, na.rm = T)[[1]],
  quartile1 = quantile(a4, .25, na.rm = T)[[1]],
  median = median(a4, na.rm = T),
  mean = mean(a4, na.rm = T),
  quartile3 = quantile(a4, .75, na.rm = T)[[1]],
  percent90 = quantile(a4, .9, na.rm = T)[[1]],
  maximum = max(a4, na.rm = T),
  range = 6,
  stdev = sd(a4, na.rm = T),
  missing = 2
)
expect_equal(summary_stats(a4), a4_s)

# Tests for rescale100
context("Tests for rescale100")
expect_equal(rescale100(c(1, 2, 3), 0, 10), c(10, 20, 30))
expect_equal(rescale100(c(1, 2, 3), 0, 16), c(6.25, 12.5, 18.75))
expect_equal(rescale100(c(1, 2, 3), 0, 20), c(5, 10, 15))
expect_equal(rescale100(c(10, 100, 1000), 0, 100), c(10, 100, 1000))

# Tests for drop_lowest
context("Tests for drop_lowest")
test_that("", {
  expect_equal(drop_lowest(v1), c(2, 3, 4, 5))
  expect_equal(drop_lowest(v2), c(0 , -1, 5, 10))
  expect_equal(drop_lowest(v3), c(-4, 0, 1, 3, 7))
  expect_equal(drop_lowest(v4), c(NA, 3, 2, 8))
})

# Tests for score_homework
context("Tests for score_homework")
expect_equal(score_homework(a1, F), mean(a1, na.rm = T))
expect_equal(score_homework(a2, T), mean(drop_lowest(a2), na.rm = T))
expect_equal(score_homework(a3, T), mean(drop_lowest(a3), na.rm = T))
expect_equal(score_homework(a4, F), mean(a4, na.rm = T))

# Tests for score_quiz
context("Tests for score_quiz")
expect_equal(score_quiz(a1, T), mean(drop_lowest(a1), na.rm = T))
expect_equal(score_quiz(a2, F), mean(a2, na.rm = T))
expect_equal(score_quiz(a3, F), mean(a3, na.rm = T))
expect_equal(score_quiz(a4, T), mean(drop_lowest(a4), na.rm = T))

# Tests for score_lab
context("Tests for score_lab")
expect_equal(score_lab(11), 100)
expect_equal(score_lab(7), 20)
expect_equal(score_lab(5), 0)
expect_equal(score_lab(8), 40)