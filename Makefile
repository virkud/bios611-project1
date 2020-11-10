.PHONY: clean
.PHONY: shiny_app
SHELL: /bin/bash

clean:
	rm -f derived_data/*.csv
	rm -f figures/*.png
	rm -f report.pdf

report.pdf:\
 report.tex\
 figures/hf_age_sex.png\
 figures/all_age_sex.png\
 figures/all_age_sex_new.png\
 figures/eth_sex.png
	pdflatex report.tex

simreport.pdf:\
 simreport.tex\
 figures/sim_hf_age_sex.png\
 figures/sim_all_age_sex.png\
 figures/sim_all_age_sex_new.png\
 figures/sim_eth_sex.png
	pdflatex simreport.tex
	
derived_data/hf_dem.csv\
derived_data/hf_pred.csv\
derived_data/hf_rx.csv\
derived_data/all_dem.csv:\
 Datasetup.R\
 source_data/patients.csv\
 source_data/d_icd_diagnoses.csv\
 source_data/diagnoses_icd.csv\
 source_data/admissions.csv\
 source_data/d_items.csv\
 source_data/prescriptions.csv
	Rscript Datasetup.R

derived_data/sim_hf_dem.csv\
derived_data/sim_hf_pred.csv\
derived_data/sim_all_dem.csv:\
 simdata.R
	Rscript simdata.R

shiny_app:\
 derived_data/s_app.csv\
 shiny_app.R
	Rscript shiny_app.R ${PORT}

derived_data/s_app.csv:\
 derived_data/hf_rx.csv\
 shiny_app_pre.R
	Rscript shiny_app_pre.R

figures/sim_all_age_sex.png\
figures/sim_hf_age_sex_new.png\
figures/sim_hf_age_sex.png:\
 sim_pop_pyramids.R\
 derived_data/sim_hf_dem.csv\
 derived_data/sim_all_dem.csv
	Rscript sim_pop_pyramids.R
		
figures/sim_eth_sex.png:\
 sim_demographic_stats.R\
 derived_data/sim_hf_dem.csv\
 derived_data/sim_all_dem.csv
	Rscript sim_demographic_stats.R
	
figures/all_age_sex.png\
figures/hf_age_sex_new.png\
figures/hf_age_sex.png:\
 pop_pyramids.R\
 derived_data/hf_dem.csv\
 derived_data/all_dem.csv
	Rscript pop_pyramids.R
		
figures/eth_sex.png:\
 demographic_stats.R\
 derived_data/hf_dem.csv\
 derived_data/all_dem.csv
	Rscript demographic_stats.R

assets/hf_age_sex.png: figures/hf_age_sex.png
	cp figures/hf_age_sex.png assets/hf_age_sex.png

assets/all_age_sex.png: figures/all_age_sex.png
	cp figures/all_age_sex.png assets/all_age_sex.png