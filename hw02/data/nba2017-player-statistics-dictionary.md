# NBA 2017 Player Statistics Data Dictionary

### Description: 

The nba2017-player-statistics.csv file contains specific data on individual NBA players who are on the 2016-2017 roster for their specific teams. The player's years of experience, salary, rank, age, and other statistics from games played are recorded. Excluding the first label row, the data has **441 rows** and **24 columns** containing individual player statistics. 

1. Column labels: Player, Team, Position, Experience, Salary, Rank, Age, GP, GS, MIN, FGM, FGA, Points3, Points3_atts, Points2, Points2_atts, FTM, FTA, OREB, DREB, AST, STL, BLK, and TO
2. There are no null values in the data; however, for the Experience label, R is entered into the data instead of 0, to show that those players are rookies.

  The following are the full descriptions of labels with corresponding units of measurements:
  
   > • Player: first and last names of player  
   > • Team: 3-letter team abbreviation\
   > • Position: player’s position\
   > • Experience: years of experience in NBA (a value of R means rookie) / Units: Years\
   > • Salary: player salary in dollars / Units: $\
   > • Rank: Rank of player in his team\
   > • Age: Age of Player at the start of February 1st of that season. / Units: Year\
   > • GP: Games Played furing regular season\
   > • GS: Games Started\
   > • MIN: Minutes Played during regular season / Units: Minutes\
   > • FGM: Field Goals Made\
   > • FGA: Field Goal Attempts\
   > • Points3: 3-Point Field Goals\
   > • Points3_atts: 3-Point Field Goal Attempts\
   > • Points2: 2-Point Field Goals\
   > • Points2_atts: 2-Point Field Goal Attempts\
   > • FTM: Free Throws Made\
   > • FTA: Free Throw Attempts\
   > • OREB: Offensive Rebounds\
   > • DREB: Defensive Rebounds\
   > • AST: Assists\
   > • STL: Steals\
   > • BLK: Blocks\
   > • TO: Turnovers\


Main source: https://www.basketball-reference.com

Sample statistics for Golden State Warriors: https://www.basketball-reference.com/teams/GSW/2017.html  