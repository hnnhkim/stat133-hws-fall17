# Title: Remove Missing / remove_missing()
# Arguments: vector 'a'
# Description: Takes a vector and returns the input vector without missing values.
# Output: vector 
remove_missing = function(a) {
  return(a[!is.na(a)])
}

# Title: Get Minimum / get_minimum()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: Finds the minimum value and na.rm tells the function to remove the as.double(NA)'s
# Output: numeric value
get_minimum = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }
  min_val = a[1]
  for(i in a) {
    if(is.na(i)) {
      return(as.double(NA))
    }
    if(i < min_val) {
      min_val = i
    }
  }
  return(min_val)
}

# Title: Get Maximum / get_maximum()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: Finds the maximum value and na.rm tells the function to remove the as.double(NA)'s
# Output: numeric value
get_maximum = function(a, na.rm){
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }
  max_val = a[1]
  for(i in a) {
    if(i > max_val) {
      max_val = i
    }
  }
  return(max_val)
}

# Title: Get Range / get_range()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: computes the overall range of the input vector
# Output: numeric value
get_range = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }
  return(get_maximum(a, na.rm = TRUE) - get_minimum(a, na.rm = TRUE))
}

# Title: Get Median / get_median()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: Computes the median of the input vector. If odd number of results, 
#             median is the middle number. If there is an even number of results, the median
#             will be the mean of the two central numbers.
# Output: numeric value
get_median = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  } else if(length(remove_missing(a) < length(a))) {
    return(as.double(NA))
  }
  return(quantile(a, c(.50))[[1]])
}

# Title: Get Average / get_average()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: Computes the mean of the input vector
# Output: numeric value
get_average = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  sum = 0
  for(i in a) {
    sum = sum + i
  }
  return(sum/length(a))
}

# Title: Get Standard Deviation / get_stdev()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: Computes the standard deviation of the input vector.
# Output: numeric value
get_stdev = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }
  avg = get_average(a, na.rm = FALSE)
  sum = 0
  for(i in a) {
    sum = sum + (i - avg)**2
  }
  return(sqrt((1/(length(a)-1)) * sum))
}

# Title: Get First Quartile / get_quartile1()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: computes the first quartile of the input vector
# Output: numeric value
get_quartile1 = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }else if(length(remove_missing(a) < length(a))) {
    return(as.double(NA))
  }
  return(quantile(a, c(.25))[[1]])
}

# Title: Get Third Quartile / get_quartile3()
# Arguments: a numeric vector 'a' and an optional logical na.rm argument
# Description: computes the third quartile of the input vector
# Output: numeric value
get_quartile3 = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }else if(length(remove_missing(a) < length(a))) {
    return(as.double(NA))
  }
  return(quantile(a, c(.75))[[1]])
}

# Title: Count Missing / count_missing()
# Arguments: numeric vector
# Description: Calculates the number of missing values as.double(NA)
# Output: numeric value
count_missing = function(a) {
  return(length(a[is.na(a)]))
}

# Title: Summmary Stats / summary_stats()
# Arguments: numeric vector 'a'
# Description: Returns a list of summary statistics
# Output: list
summary_stats = function(a) {
  newA = list(minimum = get_minimum(a, na.rm = TRUE),
              percent10 = get_percentile10(a, na.rm = TRUE),
              quartile1 = get_quartile1(a, na.rm = TRUE),
              median = get_median(a, na.rm = TRUE),
              mean = get_average(a, na.rm = TRUE),
              quartile3 = get_quartile3(a, na.rm = TRUE),
              percent90 = get_percentile90(a, na.rm = TRUE),
              maximum = get_maximum(a, na.rm = TRUE),
              range = get_range(a, na.rm = TRUE),
              stdev = get_stdev(a, na.rm = TRUE),
              missing = count_missing(a))
  return(newA)
}

# Title: Print Stats / print_stats()
# Arguments: list of summary statistics
# Description: takes a list of summary statistics, and prints the values in a nice format
# Output: printed statements
print_stats = function(stats){
  maxNameLength = 9
  formatedNames = c(" minimum  :",
                    "percent10:",
                    "quartile1:",
                    "median   :",
                    "mean     :",
                    "quartile3:",
                    "percent90:",
                    "maximum  :",
                    "range    :",
                    "stdev    :",
                    "missing  :")
  values = unlist(stats, use.names = FALSE)
  #values = format(values, nsmall = 4)
  cat(sprintf("%-9s %.4f\n", formatedNames, values))
}

# Title: Rescale 100 / rescale100()
# Arguments: a numeric vector x, a minimum 'xmin', and a maximum 'xmax'
# Description: compute a rescaled vector with a potential scale from 0 to 100
# Output: numeric vector
rescale100 = function(x, xmin, xmax) {
  return (((x - xmin)/(xmax - xmin))*100)
}

# Title: Drop Lowest / drop_lowest()
# Arguments: numeric vector 'a'
# Description: takes a numeric vector of length 'n', and returns a vector of length n - 1 by dropping the lowest value
# Output: vector of length n - 1
drop_lowest = function(a) {
  min = get_minimum(a, na.rm = FALSE)
  for (i in 1:length(a)) {
    if(is.na(a[i]) | a[i] == min) {
      return(a[-i])
    }
  }
}

# Title: Score Homework / score_homework()
# Arguments: a numeric vector 'a', optional logical argument 'drop'
# Description: Compute a single homework value. If drop = TRUE, the
#              lowest HW score must be dropped
# Output: numeric value
score_homework =  function (a, drop) {
  if (missing(drop)) {
    return(get_average(a, na.rm = TRUE))
  }
  if (drop == TRUE) {
    return (get_average(drop_lowest(a), na.rm = TRUE))
  }
  if (drop == FALSE){
    return (get_average(a, na.rm = TRUE))
  }
}

# Title: Score Quiz / score_quiz()
# Arguments: numeric vector of quiz scores and an optional logical argument drop
# Description: Computes a single quiz value. If drop = TRUE, the lowest quiz score
#              must be dropped.
# Output: numeric value
score_quiz = function (a, drop) {
  if (missing(drop)) {
    return(get_average(a, na.rm = TRUE))
  }
  if (drop == TRUE) {
    return (get_average(drop_lowest(a), na.rm = TRUE))
  }
  if (drop == FALSE){
    return (get_average(a, na.rm = T))
  }
}

# Title: Score Lab / score_lab()
# Arguments: numeric value
# Description: uses a table to compute lab scores
# Output: numeric value
score_lab = function(value) {
  if ((value == 11) | (value == 12)) {
    return(100)
  }
  else if (value == 10) {
    return(80)
  }
  else if (value == 9) {
    return(60)
  }
  else if (value == 8) {
    return(40)
  }
  else if (value == 7) {
    return(20)
  }
  else if (value >= 0 & value <= 6) {
    return (0)
  }
  else {
    return(as.double(NA))
  }
}

# Title: Get 10th percentile / get_percentile10
# Arguments: a numeric vector v and an optional logical na.rm argument
# Description: computes the 10th percentile of the input vector
# Output: numeric value
get_percentile10 = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }else if(length(remove_missing(a) < length(a))) {
    return(as.double(NA))
  }
  return(quantile(a, c(.10))[[1]])
}

# Title: Get 90th percentile / get_percentile90()
# Arguments: a numeric vector v and an optional logical na.rm argument
# Description: computes the 90th percentile of the input vector
# Output: numeric value
get_percentile90 = function(a, na.rm) {
  if (! is.numeric(a)) {
    return("non-numeric argument")
  }
  if (na.rm) {
    a = remove_missing(a)
  }else if(length(remove_missing(a) < length(a))) {
    return(as.double(NA))
  }
  return(quantile(a, c(.90))[[1]])
}