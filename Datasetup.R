#install.packages("data.table")
#install.packages("R.utils")
library(tidyverse)
library(data.table)

#In progress attempt to macrotize the pulling of datasets
# dat.func <- function(location,file1,filet){
#   setwd(paste0("~/source_data/physionet.org/files/mimiciv/0.4/",location))
#   filet <- read_csv(paste0(file1,".csv.gz"))
#   save (filet, file=paste0("~/source_data/physionet.org/files/mimiciv/0.4/alldata/",location,"_", file1))}
#dat.func("core", "admissions", admissions)
#dat.func("core", "patients", patients)
#dat.func("hosp", "d_icd_diagnoses", icd_diagnoses)

#loading datasets
setwd("~/source_data/physionet.org/files/mimiciv/0.4/core")
admissions <- read_csv(paste0("admissions.csv.gz"))
save (admissions, file=paste0("~/source_data/physionet.org/files/mimiciv/0.4/alldata/core_admissions"))

setwd("~/source_data/physionet.org/files/mimiciv/0.4/core")
patients <- read_csv(paste0("patients.csv.gz"))
save (admissions, file=paste0("~/source_data/physionet.org/files/mimiciv/0.4/alldata/core_patients"))

icddx <- read_csv("~/source_data/physionet.org/files/mimiciv/0.4/hosp/d_icd_diagnoses.csv.gz")
save (icddx, file="~/source_data/physionet.org/files/mimiciv/0.4/alldata/hosp_icddx")

dx <- read_csv("~/source_data/physionet.org/files/mimiciv/0.4/hosp/diagnoses_icd.csv.gz")
save (dx, file="~/source_data/physionet.org/files/mimiciv/0.4/alldata/hosp_dx")

dx <- read_csv("~/source_data/physionet.org/files/mimiciv/0.4/hosp/diagnoses_icd.csv.gz")
save (dx, file="~/source_data/physionet.org/files/mimiciv/0.4/alldata/hosp_dx")

chart <- load("~/source_data/physionet.org/files/mimiciv/0.4/alldata/chartevents")

hf_dx1 <- dx %>% keep(subject_id, hadm_id, seq_num) %>% filter(icd_version==9 & substr(icd_code,1,3) %in%("428") & seq_num < 3|icd_version==10 & substr(icd_code,1,3) %in%("I50") & seq_num < 3) 
hf_dx2 <- left_join(hf_dx1, chartevents) %>% left_join(.,patients)
hf_dx <- left_join(hf_dx2, admissions)

save(hf_dx, file="~/derived_data/data")
