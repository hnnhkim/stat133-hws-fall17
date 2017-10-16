# ================================================================
# Title: HW03 Ranking NBA Teams
# Description: The purpose of this script is to prepare the data 
# from NBA roster and stat files and put them into 'nba2017-teams.csv'.
# from NBA roster and stats files to create a teams file.
# Input(s): data file 'nba2017-roster.csv' and 'nba2017-stats.csv'
# Output(s): data file 'nba2017-teams.csv'
# =================================================================

# Data Preparation

## download RData file into working directory
github <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/"
csv <- "nba2017-roster.csv"
download.file(url = paste0(github, csv), destfile = '../data/nba2017-roster.csv')
csv <- "nba2017-stats.csv"
download.file(url = paste0(github, csv), destfile = '../data/nba2017-stats.csv')

nbaroster <- read.csv(file = '../data/nba2017-roster.csv', stringsAsFactors = FALSE)
nbastats <- read.csv(file = '../data/nba2017-stats.csv', stringsAsFactors = FALSE)

## adding new variables
library(dplyr)
missed_fg = nbastats$field_goals_atts - nbastats$field_goals_made
missed_ft = nbastats$points1_atts - nbastats$points1_made
points = nbastats$points1_made + (2 * nbastats$points2_made) + (3 * nbastats$points3_made) 
rebounds = nbastats$off_rebounds + nbastats$def_rebounds
efficiency = (points + rebounds + nbastats$assists + nbastats$steals + nbastats$blocks 
              - missed_fg - missed_ft - nbastats$turnovers) / nbastats$games_played
nbastats <- mutate(nbastats, missed_fg, missed_ft, points, rebounds, efficiency)

sink(file = '../output/efficiency-summary.txt')
summary(efficiency)
sink()

## merging tables
nbamerged <- merge(nbaroster, nbastats)

# Creating nba2017-teams.csv
teams <- nbamerged %>%
  group_by(team) %>%
  summarise(experience = round(sum(experience), 2), 
            salary = round(sum(salary/1000000), 2), 
            points3 = sum(points3_made),
            points2 = sum(points2_made),
            free_throws = sum(points1_made),
            points = sum(points),
            off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds),
            assists = sum(assists),
            steals = sum(steals),
            blocks = sum(blocks),
            turnovers = sum(turnovers),
            fouls = sum(fouls),
            efficiency = sum(efficiency)
            )

summary(teams)

sink(file = '../output/teams-summary.txt')
summary(teams)
sink()

write.csv(x = teams, file = '../data/nba2017-teams.csv')

##Some graphics
pdf(file = '../images/teams_star_plot.pdf')
stars(teams[,-1], labels = teams$team)
dev.off()

library(ggplot2)
pdf(file = '../images/experience_salary.pdf')
ggplot(data = teams, aes(x = experience, y = salary)) + 
  geom_point() + ggtitle("Experience vs. Salary")
dev.off()