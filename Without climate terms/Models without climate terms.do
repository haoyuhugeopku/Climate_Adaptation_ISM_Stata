*Import a wide panel file
import excel "D:\analysis\ppmlhdfe.xlsx", sheet("Sheet1") firstrow

*Define work environment
cd D:\analysis\noclimate

*Convert wide panels to long panels
reshape long m pergdpo pergdpd popo popd org remito remitd tradeo traded unio unid vulno vulnd readyo readyd polio polid eco_readyo eco_readyd gov_readyo gov_readyd soc_readyo soc_readyd, i(id) j(year)

*Generate panel structure
xtset id year

*Generate ratio
gen vro=vulno/readyo
gen vrd=vulnd/readyd
gen rvo=readyo/vulno
gen rvd=readyd/vulnd

*Generate logarithmic variables
foreach v of varlist m geodist clidist popd popo pergdpo pergdpd remito remitd vulno vulnd readyo readyd eco_readyo eco_readyd gov_readyo gov_readyd soc_readyo soc_readyd{
gen ln_`v'=log(`v')
}
gen ln_unio = log(unio+1)
gen ln_unid = log(unid+1)

*Generate ID
egen o_id = group(o)
egen d_id = group(d)

*Generate interaction items
foreach v of varlist vro vrd{
gen `v'_ln_clidist=`v'*ln_clidist
gen `v'_ln_geodist=`v'*ln_geodist
}

*Regression
ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo,r absorb(year#d_id) nolog
est sto r1

ppmlhdfe m ln_geodist colony contig legal ln_unid ln_popd ln_pergdpd,r absorb(year#o_id) nolog
est sto r2

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_unid ln_popd ln_pergdpd,r absorb(year o_id#d_id) nolog
est sto r3

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_unid ln_popd ln_pergdpd,r absorb(year o d) nolog
est sto r4

esttab r1 r2 r3 r4 using robust.rtf, replace
