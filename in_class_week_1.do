//Week 1 - Create a new variable, MPG as a % of MPG
//author: Hensel 4/6/17

cd "C:\Users\Ian\OneDrive\EC410 - STATA and R/Week_1"

//LOAD DATASET
sysuse auto, clear

//find what directory your working in
pwd
//change directory
//cd pathnme

gen mpg_sum = sum(mpg)

// _N means last observation

gen mpg_avg = mpg_sum[_N]/_N

gen mpg_pct = mpg/mpg_avg*100

sum mpg_pct
sum mpg_pct mpg_avg

//LABEL your variables
label variable mpg_pct "MPG as a perrcent of average MPG"

//describe data
d 
sum

/* Comments */
//another method using summarize comand

sum
return list
replace mpg_pct = mpg/r(mean)*100

