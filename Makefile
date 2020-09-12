.PHONY: clean
SHELL: /bin/bash

clean:
	rm derived_data/*
	
figures/all_age_sex.png\
	figures/hf_age_sex.png:\
	Analysis.R\
	derived_data/hf_dem.csv\
	derived_data/all_dem.csv
		Rscript Analysis.R