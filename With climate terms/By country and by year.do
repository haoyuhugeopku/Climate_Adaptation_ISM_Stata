*By country

foreach condition of varlist dvgdvd dvddvg dvgdvg dvddvd{

ppmlhdfe M ln_GeoDist Colony Contig Legal ln_UniO ln_PopO ln_PerGDPO ln_VulnO ln_ReadyO VRO_ln_CliDist if `condition' == 1,r absorb(year#D_id) nolog
est sto `condition'1

ppmlhdfe M ln_GeoDist Colony Contig Legal ln_UniD ln_PopD ln_PerGDPD ln_VulnD ln_ReadyD VRD_ln_CliDist if `condition' == 1,r absorb(year#O_id) nolog
est sto `condition'2

ppmlhdfe M ln_GeoDist Colony Contig Legal ln_UniO ln_PopO ln_PerGDPO ln_VulnO ln_ReadyO VRO_ln_CliDist ln_UniD ln_PopD ln_PerGDPD ln_VulnD ln_ReadyD VRD_ln_CliDist if `condition' == 1,r absorb(year O_id#D_id) nolog
est sto `condition'3
}

esttab dvgdvd1 dvgdvd2 dvgdvd3 dvddvg1 dvddvg2 dvddvg3 dvgdvg1 dvgdvg2 dvgdvg3 dvddvd1 dvddvd2 dvddvd3 using country.rtf, replace

*By year

global list "year<2009 2008<year&year<2015 year>2014" 
foreach year in $list{

ppmlhdfe M ln_GeoDist Colony Contig Legal ln_UniO ln_PopO ln_PerGDPO ln_VulnO ln_ReadyO VRO_ln_CliDist if `year',r absorb(year#D_id) nolog
est sto year1

ppmlhdfe M ln_GeoDist Colony Contig Legal ln_UniD ln_PopD ln_PerGDPD ln_VulnD ln_ReadyD VRD_ln_CliDist if `year',r absorb(year#O_id) nolog
est sto year2

ppmlhdfe M ln_GeoDist Colony Contig Legal ln_UniO ln_PopO ln_PerGDPO ln_VulnO ln_ReadyO VRO_ln_CliDist ln_UniD ln_PopD ln_PerGDPD ln_VulnD ln_ReadyD VRD_ln_CliDist if `year',r absorb(year O_id#D_id) nolog
est sto year3

esttab year1 year2 year3 using year.rtf, append
}

