//Week_2
//Author: Ian Hensel

//Task 1 
/* calc num of fam members in each hh */

use "sex_age08.dta", clear

sort province-hhcode
//province-hhcode all together are a uniqueID

by province-hhcode: gen hhnum = _n //generate a variable for each hh member
by prov-hhc: keep if _n == _N //keeps value if the current value is the last
l hhnum
/* NOTE: Becuse we have the data sorted each member of the hh gets a number.
we want to keep the entry if the hh member number is the last number of that hh
this gives us a count of the people of the house hold */ 

collapse (max) pcode, by(prov-hhcode) // Use the max value for ppcode per hh
l pcode

hist pcode // distribution of family size is unimodal centered at mean ~4 ppl

// Task 2 - average education levels in Veitnam by minority status
// Process: merge sexage + minority data to calculate 

/* NOTE: province-hhcode variables combined to make uniqueID
We need to sort then merge the two data sets, we know that both data sets 
include province-hhcode */

clear
use "sex_age08.dta", clear
sort province-hhcode
save sex_age08_sort, replace // save the sorted version of file

use "minority08.dta", clear

merge 1:m province-hhcode using sex_age08_sort // One-to-many merge

save vietnam_merge, replace

collapse (mean) educ, by(minority)
l //Non-Minority have higher average education level

// province county commune village hhcode
use "C:\Users\Ian\OneDrive\EC410 - STATA and R\Week_2\sex_age08.dta", clear
sort province county commune village hhcode


use "C:\Users\Ian\OneDrive\EC410 - STATA and R\Week_2\minority08.dta", clear


//Task 3 -how much did the real oregon minimum wage go up or down 1968-2017?
//Process: merge OR_minwage and cpi, calculate real_wage, keep data end periods
// calculate difference.  

import excel "OR_minwage.xlsx", sheet("Sheet1") firstrow, clear

describe
sort year
save minOR, replace

import excel "cpi.xlsx", clear

rename A year
rename B cpi
sort year

// Remember to sort before merging

merge 1:1 year using minOR // one-to-one merge

// Drop odd years that have wage value of '.'
drop if  minwage_OR == .

// Calculate: real wage = nominal wage / CPI
gen real_wage= minwage_OR[_n] / cpi[_n]

// we are only interested in the difference over the period
keep if year==1968 | year ==2017

gen wage_diff = real_wage[_N] - real_wage[_n]
l wage_diff

gen wage_growth = ln( real_wage[_N] / real_wage[_n]) / (2017 - 1968) // not working

l wage_growth

// (confused??) alt. method using nominal wage: 0.0419 = ln(9.75 / 1.25) / (2017 - 1968)




