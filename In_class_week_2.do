/* Week 2 In class
Author: Ian Hensel

We can use a profile.do to set up our work environment 
for subsequent do files.

Increase the buffer of the results window, put with program files
use comand: 'adopath' to see where stata checks for profile.do */

// Comments
// '//' = doesnt read the line
// '///' = will not read 
// '/* <start> <end> */ = blocks out code or notes and useful for debugging. 
// '*' = first character of the line it will not read the line

// Reorganize Data

// Calculate discriptive stats
// have a precise purpose for each number you include in a presentation



sysuse auto

// 
tab rep78
sort rep78 // must be sorted before 'by'
by rep78: gen mpg_max = mpg[_N]
by rep78: sum mpg
by rep78: list mpg mpg_max if _n==_N // this uses by variable to parse the sorted catigories

// simpler option :-)
// collapse - shrink catagories default stat is mean, need to indicated stat if other
// NOTE: Collapse destroys underlying data!!!
collapse (max) mpg, by(rep78)
l // 'l' short for list


//define label lets us put text labels on numeric data
label define replbl 1 "Teribble" 2 "Poor" 3 "OK" 4 "Good" 5 "Excellent"
label values rep78 replbl
l

//Merge - merge two data sets, cpi and ORwages
