//Week 1 Exercise
//Hensel

// goal: calcuate mpg as % of max using auto.dta

sysuse auto, clear
sort mpg
gen mpg_pmax = mpg/mpg[_N]*100
label variable mpg_pmax "MPG as a percent of max MPG"
sum mpg

//another way

sum mpg
return list

replace mpg_pmax = mpg/r(max)*100

list mpg_pmax
