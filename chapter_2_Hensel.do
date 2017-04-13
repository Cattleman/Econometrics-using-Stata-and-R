// Hensel 4/5/2017


// 2.1.1 The use comand

use http://www.stata-press.com/data/imeus/census2c, clear
list, sep(0)

// 2.1.2 Variable types
describe

// 2.1.4 generate and replace
generate urbanized = popurb/pop
sum urbanized
replace urbanized = 100*urbanized
sum urbanized

//2.1.5 sort and gsort
gsort region -pop
list region state pop, sepby(region)


//2.1.6 if exp and in range
generate medagel = medage if pop > 5000
sort pop
list state region pop in 1/5
list state region pop in -5/1
gsort -pop
list state region pop in 1/5
//2.1.7 Using if with indicator variables

generate medagel = medage if pop > 5000
sort state
list state region pop medagel, sep(0)
summarize medagel

// make a dummy variable
generate smallpop = 0
replace smallpop = 1 if pop <=5000


generate largepop = 0
replace largepop = 1 if pop > 5000
list state pop smallpop largepop, sep(0)

label variable medagel "median age of states with > 5mil pop"
sort state

list state region pop medagel, sep(0)
sum medagel
sum medage if pop > 5000

//2.1.8 using if vs by
sum medage marr divr if region ==1
sum medage marr divr if region==2

by region, sort: sum medage marr divr

// by() modifies the comand telling stata to compute a table with summ stats
//for each region
tabstat medage, by(region) statistics(N mean sd min max)

// 2.1.9 Labels and Notes

label data "1980 US Census data with population size indicators"
label variable urbanized "Population in urban areas, %"
label variable smallpop "State with <=5 million pop, 1980"
label variable largepop "State with > 5 million pop, 1980"
//See the changes to labels
describe pop smallpop largepop urbanized


notes: Subset of census data, prepared on TS for Chapter 2
notes medagel: median age for large states only
describe

notes
// 2.1.10 The varlist
// wildcard (*) *pop means pop, smallpop, largepop
// can also use hyphenated list cat1-cat4 variables cat1 through cat4 

//2.1.11 drop and keep
//drop varlist
//keep varlist, can modify with if, in

//2.1.12 rename and renvars 

//rename old_varname new_varname

rename smallpop tinypop
rename tinypop smallpop

//2.2 COMMON DATA TRANSFORMATIONS

//2.2.1 The cond() function
help cond()
generate netmarr2x = cond(marr/divr > 2, 1,2)
label define netmarr2xc 1 "marr > divr" 2 "marr <= 2 divr"
label values netmarr2x netmarr2xc
tabstat pop medage, by(netmarr2x)

//2.2.2 Recoding discrete and continuous variables
//the vertical bar ( | ) is Stata's "or" operator

histogram medagebrack, discrete frequency

// 2.2.4 String-to-numeric conversion and vice versa
use "http://www.stata-press.com/data/imeus/census2a"
//2.2.5 Handling Dates

// 2.2.7 The egen Command 
