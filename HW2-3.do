*Generate transformation
tab year, gen(yr)

*Regressions (a)
xtabond k yr2-yr9, vce(r)	

*Regressions (b)
xtdpdsys k yr2-yr9, vce(r)