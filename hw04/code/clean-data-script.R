# ==================================================================
# Title: Cleaning Data for Data Preparation
# Description: This script cleans the data and adds some more values
# Input: csv files
# Output: cleaned csv files and summary files
# ==================================================================

library(dplyr)
source("functions.R")

# read in the CSV file with the raw scores
file = "../data/rawdata/rawscores.csv"
dat = read.csv(file = file, stringsAsFactors = F)
cleaned_file = "../data/cleandata/cleanscores.csv"

# sink() structure str() of the data frame of raw scores
sink(file = '../output/summary-rawscores.txt')
str(dat)
for (i in 1:ncol(dat)) {
  summary = summary_stats(dat[,i])
  print_stats(summary)
}
sink()

# replacing all missing values NA with zero
for (i in 1:ncol(dat)) {
  dat[is.na(dat[,i]),i] = 0
}

# rescaling quiz scores
dat$QZ1 = rescale100(x = dat$QZ1, xmin = 0, xmax = 12)
dat$QZ2 = rescale100(x = dat$QZ2, xmin = 0, xmax = 18)
dat$QZ3 = rescale100(x = dat$QZ3, xmin = 0, xmax = 20)
dat$QZ4 = rescale100(x = dat$QZ4, xmin = 0, xmax = 20)

# rescaling test scores
dat$Test1 = rescale100(x = dat$EX1, xmin = 0, xmax = 80)
dat$Test2 = rescale100(x = dat$EX2, xmin = 0, xmax = 90)

# add variable Homeowrk to data frame of scores
hw = 1:nrow(dat)
for(i in hw) {
  v = as.numeric(dat[i, 1:9])
  hw[i] = get_average(drop_lowest(v), na.rm = F)
}
dat$Homework = hw

# add variable Quiz to data frame of scores
q = 1:nrow(dat)
for(i in q) {
  v = as.numeric(dat[i, 11:14])
  q[i] = get_average(drop_lowest(v), na.rm = F)
}
dat$Quiz = q

# add variable Overall to the data frame of scores
o = 1:nrow(dat)
for(i in o) {
  v = as.numeric(dat[i, c("ATT", "Homework", "Quiz", "Test1", "Test2")])
  v[1] = score_lab(v[1])
  weight = c(.1, .3, .15, .2, .25)
  o[i] = sum(v*weight)
}
dat$Overall = o

# calculate a variable Grade and add it to the data frame of scores
g = vector(mode = "character")
for (i in 1:nrow(dat)) {
  grade = dat[i, "Overall"]
  if (grade <= 100 & grade >= 95) {
    g[i] = "A+"
  } else if (grade < 95 & grade >= 90) {
    g[i] = "A"
  } else if (grade < 90 & grade >= 88) {
    g[i] = "A-"
  } else if (grade < 88 & grade >= 86) {
    g[i] = "B+"
  } else if (grade < 86 & grade >= 82) {
    g[i] = "B"
  } else if (grade < 82 & grade >= 79.5) {
    g[i] = "B-"
  } else if (grade < 79.5 & grade >= 77.5) {
    g[i] = "C+"
  } else if (grade < 77.5 & grade >= 70) {
    g[i] = "C"
  } else if (grade < 70 & grade >= 60) {
    g[i] = "C-"
  } else if (grade < 60 & grade >= 50) {
    g[i] = "D"
  } else {
    g[i] = "F"
  }
}
dat$Grade = g

# for loop in which summary_stats() and print_stats() export summary statistics
l = 1:nrow(dat)
for(i in l) {
  v = as.numeric(dat[i, c("ATT")])
  l[i] = score_lab(v[1])
}
dat$Lab = l
names = c("Lab", "Homework", "Quiz", "Test1", "Test2", "Overall")
end = "-stats.txt"
begin = "../output/"
for(s in names) {
  sink(file = paste(begin, s, end, sep = ''))
  print_stats(summary_stats(dat[,s]))
  sink()
}

# sink() structure str() of the data frame of clean scores
sink(file = '../output/summary-cleanscores.txt')
str(dat)
for (i in 1:ncol(dat)) {
  summary = summary_stats(dat[,s])
  print_stats(summary)
}
sink()

# export clean data frame of scores to CSV file
write.csv(x = dat, file = "../data/cleandata/cleanscores.csv")
