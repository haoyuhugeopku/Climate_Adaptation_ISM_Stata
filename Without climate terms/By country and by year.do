*By country

foreach condition of varlist dvgdvd dvddvg dvgdvg dvddvd{

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo if `condition' == 1,r absorb(year#d_id) nolog
est sto `condition'1

ppmlhdfe m ln_geodist colony contig legal ln_unid ln_popd ln_pergdpd if `condition' == 1,r absorb(year#o_id) nolog
est sto `condition'2

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_unid ln_popd ln_pergdpd if `condition' == 1,r absorb(year o_id#d_id) nolog
est sto `condition'3
}

esttab dvgdvd1 dvgdvd2 dvgdvd3 dvddvg1 dvddvg2 dvddvg3 dvgdvg1 dvgdvg2 dvgdvg3 dvddvd1 dvddvd2 dvddvd3 using country.rtf, replace

*By year

global list "year<2009 2008<year&year<2015 year>2014" 
foreach year in $list{

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo if `year',r absorb(year#d_id) nolog
est sto year1

ppmlhdfe m ln_geodist colony contig legal ln_unid ln_popd ln_pergdpd if `year',r absorb(year#o_id) nolog
est sto year2

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_unid ln_popd ln_pergdpd if `year',r absorb(year o_id#d_id) nolog
est sto year3

esttab year1 year2 year3 using year.rtf, append
}
