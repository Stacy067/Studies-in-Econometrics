*Generate transformations
gen wage = log(earnings/(hours*week))

gen experience = age - education -6

gen exp2 = (experience^2)/100
 
recode region 1=1 3=0 4=0, gen(dummy1)
recode region 1=0 3=1 4=0, gen(dummy2)
recode region 1=0 3=0 4=1, gen(dummy3)
recode marital 1=1 2=0 3=0 4=0 5=0 6=0, gen(dummy4)
recode marital 1=0 2=1 3=0 4=0 5=0 6=0, gen(dummy5)
recode marital 1=0 2=0 3=1 4=0 5=0 6=0, gen(dummy6)
recode marital 1=0 2=0 3=0 4=1 5=0 6=0, gen(dummy7)
recode marital 1=0 2=0 3=0 4=0 5=1 6=0, gen(dummy8)
recode marital 1=0 2=0 3=0 4=0 5=0 6=1, gen(dummy9)

*Create indicator for subsamples
gen wmh = (race==1)&(hisp==1)&(female==0)
 
*Regressions
reg wage education experience exp2 dummy1 dummy2 dummy3 dummy4 dummy5 dummy6 dummy7 dummy8 dummy9 if wmh==1
