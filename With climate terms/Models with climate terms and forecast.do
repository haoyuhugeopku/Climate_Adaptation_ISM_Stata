*Import a wide panel file
import excel "D:\analysis\ppmlhdfe.xlsx", sheet("Sheet1") firstrow

*Define work environment
cd D:\analysis\climate

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
ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_readyo vro_ln_clidist,r absorb(year#d_id) nolog
est sto r1

ppmlhdfe m ln_geodist colony contig legal ln_unid ln_popd ln_pergdpd ln_vulnd ln_readyd vrd_ln_clidist,r absorb(year#o_id) nolog
est sto r2

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_readyo vro_ln_clidist ln_unid ln_popd ln_pergdpd ln_vulnd ln_readyd vrd_ln_clidist,r absorb(year o_id#d_id) nolog
est sto r3

esttab r1 r2 r3 using robust.rtf, replace


*Forecast
*Fixed effects
ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_readyo vro_ln_clidist ln_unid ln_popd ln_pergdpd ln_vulnd ln_readyd vrd_ln_clidist,r absorb(o_id#d_id, savefe) nolog

bys id :egen fe=mean(__hdfe1__)

*PPML
gen pr_m = exp(_b[_cons] + _b[ln_geodist]*ln_geodist + _b[colony]*colony + _b[contig]*contig + _b[legal]*legal + _b[ln_unio]*ln_unio + _b[ln_popo]*ln_popo + _b[ln_pergdpo]* ln_pergdpo + _b[ln_vulno]* ln_vulno + _b[ln_readyo]* ln_readyo + _b[vro_ln_clidist]* vro_ln_clidist + _b[ln_unid]* ln_unid + _b[ln_popd]* ln_popd + _b[ln_pergdpd]* ln_pergdpd + _b[ln_vulnd]* ln_vulnd + _b[ln_readyd]* ln_readyd + _b[vrd_ln_clidist]* vrd_ln_clidist + fe)
