.PHONY: clean
.PHONY: shiny_app
SHELL: /bin/bash

#This clean action removes any existing datasets, figures or reports generated in this Makefile
clean:
	rm -f derived_data/*.csv
	rm -f figures/*.png
	rm -f report.pdf

#The final report for this project
report.pdf:\
 report.tex\
 figures/hf_age_sex.png\
 figures/all_age_sex.png\
 figures/all_age_sex_new.png\
 figures/Log_ROC.png\
 figures/eth_sex.png
	pdflatex report.tex

#The final report using simulated data for this project
simreport.pdf:\
 simreport.tex\
 figures/sim_hf_age_sex.png\
 figures/sim_all_age_sex.png\
 figures/sim_all_age_sex_new.png\
 figures/sim_eth_sex.png
	R -e "tinytex::pdflatex(\"simreport.tex\");"

#All the datasets needed for this project
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

#Code to generate simulated datasets
derived_data/sim_hf_dem.csv\
derived_data/sim_hf_pred.csv\
derived_data/sim_all_dem.csv:\
 simdata.R
	Rscript simdata.R

#Code to generate LR classifier ROC figure
figures/Log_ROC.png:\
 derived_data/hf_pred.csv\
 LR_classifier.py
	python3 LR_classifier.py

#Shiny app build
shiny_app:\
 derived_data/s_app.csv\
 shiny_app.R
	Rscript shiny_app.R ${PORT}

#Derived dataset for the shiny app
derived_data/s_app.csv:\
 derived_data/hf_rx.csv\
 shiny_app_pre.R
	Rscript shiny_app_pre.R

#Simulated figures
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

#Figures for the README.md
assets/hf_age_sex.png: figures/hf_age_sex.png
	cp figures/hf_age_sex.png assets/hf_age_sex.png

assets/all_age_sex.png: figures/all_age_sex.png
	cp figures/all_age_sex.png assets/all_age_sex.png
