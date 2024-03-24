*Exploring readiness types

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_eco_readyo ln_gov_readyo ln_soc_readyo vro_ln_clidist,r absorb(year#d_id) nolog
est sto re1

ppmlhdfe m ln_geodist colony contig legal ln_unid ln_popd ln_pergdpd ln_vulnd ln_eco_readyd ln_gov_readyd ln_soc_readyd vrd_ln_clidist,r absorb(year#o_id) nolog
est sto re2

ppmlhdfe m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_eco_readyo ln_gov_readyo ln_soc_readyo vro_ln_clidist ln_unid ln_popd ln_pergdpd ln_vulnd ln_eco_readyd ln_gov_readyd ln_soc_readyd vrd_ln_clidist,r absorb(year o_id#d_id) nolog
est sto re3

esttab re1 re2 re3 using ready.rtf, replace