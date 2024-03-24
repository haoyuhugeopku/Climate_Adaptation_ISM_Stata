*Correlation analysis
asdoc pwcorr m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_readyo vro_ln_clidist ln_unid ln_popd ln_pergdpd ln_vulnd ln_readyd vrd_ln_clidist, star(0.001) sig  nonum replace

drop if m==.
asdoc summarize m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_readyo vro_ln_clidist ln_unid ln_popd ln_pergdpd ln_vulnd ln_readyd vrd_ln_clidist

*Collinearity test
reg m ln_geodist colony contig legal ln_unio ln_popo ln_pergdpo ln_vulno ln_readyo vro_ln_clidist ln_unid ln_popd ln_pergdpd ln_vulnd ln_readyd vrd_ln_clidist,r 
asdoc estat vif
