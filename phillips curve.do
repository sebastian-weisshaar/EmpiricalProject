*create monthts and set as time-variable
gen mdate=mofd(observation_date)
format mdate %tm
tsset mdate

*Interpolation
ipolate Unemployment mdate, gen(unemployment_inter)
ipolate NAIRU mdate, gen(nairu_inter)

*Generate DELTA inflation
replace delta_inflation=clean_inflation-L.inflation

*Generaste NAIRU diff
gen hur_diff=hur-nairu_inter

*Label the data
label variable hur "Unemployment"
label variable inflation "Inflation"
label variable energy2 "Fuel, Energy & Gasoline"
label variable working_population2 "Working Population"
label variable jpn_usa "Exchange rate USA"
label variable jpn_australia "Exchange rate Australia"
label variable jp_china "Exchange rate China"
label variable hur_diff "Unemployment deviation from the NAIRU"
label variable mdate "Date"

***BASE MODEL
regress inflation L.inflation hur L.hur energy2 working_population2 jpn_usa jpn_australia jp_china
***END


****Short range lags model
regress inflation L.inflation L6.inflation L12.inflation L18.inflation L24.inflation L.hur L2.hur L3.hur energy2 working_population2 jpn_usa jpn_australia jp_china,robust
*****END

outreg2 using main_big, tex dec(2) replace label

****Long range lags model
regress inflation L.inflation L6.inflation L12.inflation L18.inflation L24.inflation L4.hur L8.hur L12.hur energy2 working_population2 jpn_usa jpn_australia jp_china,robust
*****END

outreg2 using main_big, tex dec(2) label

****Full range lags model
regress inflation L.inflation L6.inflation L12.inflation L18.inflation L24.inflation L.hur L2.hur L3.hur L4.hur L8.hur L12.hur energy2 working_population2 jpn_usa jpn_australia jp_china,robust
*****END

outreg2 using main_big, tex dec(2) label


*Descriptive statistics
outreg2 using description, sum(detail) tex replace label eqkeep(mean sd min max p50) keep(inflation hur NAIRU energy2 working_population2 jpn_usa jpn_australia jp_china)




