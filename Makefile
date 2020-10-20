.PHONY: clean
SHELL: /bin/bash

clean:
	rm -f derived_data/*.csv
	rm -f figures/*.png
	rm -f report.pdf

report.pdf:\
 report.tex\
 figures/hf_age_sex.png\
 figures/all_age_sex.png\
 figures/all_age_sex_new.png
	pdflatex report.tex

derived_data/hf_dem.csv\
derived_data/all_dem.csv:\
 Datasetup.R\
 source_data/patients.csv\
 source_data/d_icd_diagnoses.csv\
 source_data/diagnoses_icd.csv\
 source_data/admissions.csv\
 source_data/d_items.csv\
 source_data/prescriptions.csv
	Rscript Datasetup.R
	
figures/all_age_sex.png\
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