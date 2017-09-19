Warm Up 2
================

``` r
# load the objects
load("nba2017-salary-points.RData")
# list the available objects
ls()
```

    ## [1] "experience" "player"     "points"     "points1"    "points2"   
    ## [6] "points3"    "position"   "salary"     "team"

``` r
class(points)
```

    ## [1] "integer"

``` r
class(salary)
```

    ## [1] "numeric"

``` r
class(team)
```

    ## [1] "factor"

``` r
# quick summary of statistics
summary(points)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     0.0   156.0   432.0   546.6   780.0  2558.0

``` r
summary(salary)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##     5145  1286160  3500000  6187014  9250000 30963450

``` r
summary(team)
```

    ## ATL BOS BRK CHI CHO CLE DAL DEN DET GSW HOU IND LAC LAL MEM MIA MIL MIN 
    ##  14  15  15  15  15  15  15  15  15  15  14  14  15  15  15  14  14  14 
    ## NOP NYK OKC ORL PHI PHO POR SAC SAS TOR UTA WAS 
    ##  14  15  15  15  15  15  14  15  15  15  15  14

``` r
summary(experience)
```

    ##    Length     Class      Mode 
    ##       441 character character

``` r
summary(position)
```

    ##    Length     Class      Mode 
    ##       441 character character

``` r
summary(player)
```

    ##    Length     Class      Mode 
    ##       441 character character

``` r
# statistics for salary
salary_mean <- mean(salary)
salary_mean
```

    ## [1] 6187014

``` r
salary_sd <- sd(salary)
salary_sd
```

    ## [1] 6571890

``` r
salary_min <- min(salary)
salary_min
```

    ## [1] 5145

``` r
salary_max <- max(salary)
salary_max
```

    ## [1] 30963450

``` r
salary_median <- median(salary)
salary_median
```

    ## [1] 3500000

``` r
hist(salary)
```

![](up02-hannah-kim_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

``` r
boxplot(salary)
```

![](up02-hannah-kim_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-2.png)

``` r
chosen_categorical <- factor(position)
table(chosen_categorical)
```

    ## chosen_categorical
    ##  C PF PG SF SG 
    ## 89 89 85 83 95

``` r
prop.table(table(team))
```

    ## team
    ##        ATL        BOS        BRK        CHI        CHO        CLE 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        DAL        DEN        DET        GSW        HOU        IND 
    ## 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 
    ##        LAC        LAL        MEM        MIA        MIL        MIN 
    ## 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 0.03174603 
    ##        NOP        NYK        OKC        ORL        PHI        PHO 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        POR        SAC        SAS        TOR        UTA        WAS 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603

``` r
barplot(table(team))
```

![](up02-hannah-kim_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)
