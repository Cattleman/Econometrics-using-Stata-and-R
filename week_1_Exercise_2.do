//Week 1 exercise 2
//Hensel
//World Bank Data set

ssc wbopendata

// load infanct mortality data from WDI

wbopendata, indicator(sp.dyn.imrt.in) year(2010) // 
	long clear nometadata


rename yr2010 ir
drop if regioncode == "NA"
drop if imr == .
sort imr
list countryname imr in 1/5

list countryname imr in -5/l 

/*wont include missing values*/
