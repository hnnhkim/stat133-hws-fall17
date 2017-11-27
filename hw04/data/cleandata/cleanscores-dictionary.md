# Stat 133 Raw Scores

### Description: 

The 'cleanscores.csv' file contains the cleaned scores data for a fictitious Stat 133 class. Excluding the first label row, the data has **334 rows** and **23 columns** containing player roster. 

1. Column labels: HW1, HW2, HW3, HW4, HW5, HW6, HW7, HW8, HW9, ATT, QZ1, QZ2, QZ3, QZ4, EX1, EX2, Test1, Test2, Homework, Quiz, Overall, Grade, Lab
2. There are missing values from the raw scores data is now replaced with zeros.

  The following are the full descriptions of the column labels:
  
   > • Homework Assignments: columns HW1 to HW9, each 100 points\
   > • Lab Attendance: ATT, number of attended labs (0 to 12)\
   > • Quiz Scores:
        > QZ1: 12 points
        > QZ2: 18 points
        > QZ3: 20 points
        > QZ4: 20 points
   > • Exam 1: EX1, 80 points
   > • Exam 2: EX2, 90 points
   > • Test1: rescaled EX1 with scale of 100 (0 is minimum and 80 is the maximum)
   > • Test2: rescaled EX2 with scale of 100 (0 is minimum and 90 is the maximum)
   > • Homework: average homework score with lowest homework dropped
   > • Quiz: average quiz score with lowest quiz dropped
   > • Overall: already in scale 0 to 100; calculated scores with grade weights
   > • Grade: letter grade based off of grade cutoffs
   > • Lab: lab attendance grade scaled 0 to 100