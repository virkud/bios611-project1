library(tidyverse)
library(data.table)
library(RSQLite)

#loading datasets
#setwd("~/source_data/physionet.org/files/mimiciv/0.4/icu")
#icu_chart <- read_csv("chartevents.csv.gz")

setwd("~/source_data/physionet.org/files/mimiciv/0.4/core")
#admissions <- read_csv("admissions.csv.gz")
patients <- read_csv("patients.csv.gz")

setwd("~/source_data/physionet.org/files/mimiciv/0.4/hosp")
icddx <- read_csv("~/source_data/physionet.org/files/mimiciv/0.4/hosp/d_icd_diagnoses.csv.gz")
dx <- read_csv("~/source_data/physionet.org/files/mimiciv/0.4/hosp/diagnoses_icd.csv.gz")

#Tidy Patient dataset with heart failure patients
hf_pat <- dx %>% filter(icd_version==9 & substr(icd_code,1,3) %in%("428") & seq_num < 3|
          icd_version==10 & substr(icd_code,1,3) %in%("I50") & seq_num < 3) %>% 
          select(subject_id, seq_num) %>%
          arrange(subject_id, seq_num) %>% 
          left_join(., patients) %>% 
          distinct(., subject_id, .keep_all = TRUE)

write_csv(hf_pat, "~/derived_data/hf_dem.csv")
write_csv(patients, "~/derived_data/all_dem.csv")

#The following code hasn't successfuly run yet, due to file size
setwd("~/source_data/physionet.org/files/mimiciv/0.4/icu")
charts <- read_csv("chartevents.csv.gz")
hf_dat <- dx %>% filter(icd_version==9 & substr(icd_code,1,3) %in%("428") & seq_num < 3|
                          icd_version==10 & substr(icd_code,1,3) %in%("I50") & seq_num < 3) %>% 
          select(subject_id, hadm_id, seq_num) %>%
          arrange(subject_id, hadm_id, seq_num) %>% 
          left_join(., patients) %>% left_join(., charts)
write_csv(hf_dat, "~/derived_data/hf_data.csv")

icu_chart <- dbConnect(RSQLite::SQLite(), "events.db")
dbExecute (icu_chart, "CREATE TABLE chart (subject_id INTEGER,hadm_id INTEGER, stay_id INTEGER,
          charttime TEXT, storetime TEXT, itemid INTEGER, value INTEGER, valuenum INTEGER,
           valueuom TEXT, warning INTEGER) ;")
dbExecute(icu_chart,".mode csv
.import file.headless.csv chart")
