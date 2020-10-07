library(RSQLite)
library(tidyverse)

#loading datasets
setwd("~/source_data/")
patients <- read_csv("patients.csv")
icddx <- read_csv("d_icd_diagnoses.csv")
dx <- read_csv("diagnoses_icd.csv")
admissions <- read_csv("admissions.csv")
chartlist <- read_csv("d_items.csv.gz")


#Tidy Patient dataset with heart failure patients, distinct by patients
hf_patA <- dx %>% filter(icd_version==9 & substr(icd_code,1,3) %in%("428") & seq_num < 3|
                          icd_version==10 & substr(icd_code,1,3) %in%("I50") & seq_num < 3) %>% 
  select(subject_id, seq_num) %>%
  arrange(subject_id, seq_num) %>% 
  left_join(., patients) %>% 
  distinct(., subject_id, .keep_all = TRUE) 
hf_adm <- hf_patA %>% 
  left_join(.,admissions)
hf_dem <- hf_adm %>% 
  select(-hadm_id, -admittime, -dischtime, -admission_type, -admission_location, 
         discharge_location, edregtime, edouttime, hospital_expire_flag) %>% 
  group_by(subject_id) %>% 
  count(subject_id,name=visit_num)

write_csv(hf_pat, "~/derived_data/hf_dem.csv")
write_csv(patients, "~/derived_data/all_dem.csv")

setwd("~/derived_data")
#This dataset was developed in sqlite using bash code (see sqlite)
hfevents <- read_csv("hfevents.csv") %>% select(-`hadm_id:1`, -`subject_id:1`)

#List of HF events

hflist <- hfevents %>% select(itemid) %>% 
  left_join(chartlist) %>% distinct(., itemid, .keep_all = TRUE) 

ABPs1 <- hfevents %>% filter(itemid==220050) %>% group_by(subject_id, hadm_id) %>% 
          select(-seq_num, -icd_code, -icd_version, -storetime, -stay_id, -`hadm_id:1`)
top_n(ABPs1,10)
#Medications among HF patients


