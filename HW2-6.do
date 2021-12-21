
gen exp = age76 - ed76 - 6
gen exp2 = (exp^2)/100
* Drop observations with missing wage
drop if lwage76==.

*(a)
*Table 12.2 final column for reduced form
reg ed76 exp exp2 black reg76r smsa76r nearc4a nearc4b, r
*Table 12.1 2SLS(a)
ivregress 2sls lwage76 exp exp2 black reg76r smsa76r (ed76=nearc4a nearc4b), r

*(b)
reg ed76 exp exp2 black reg76r smsa76r nearc4a nearc4b nearc2, r

*(c)
gen na = nearc4a*age76
gen na2 = nearc4a*age76^2/100
reg ed76 exp exp2 black reg76r smsa76r nearc4a nearc4b na na2, r
reg ed76 exp exp2 black reg76r smsa76r nearc4a nearc4b nearc2 na na2, r

*(d)
ivregress 2sls lwage76 exp exp2 black reg76r smsa76r (ed76=nearc4a nearc4b na na2), r

*(e)
estat firststage

*(f)
estat endogenous ed76





