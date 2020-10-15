library(RSQLite)
library(tidyverse)

#loading datasets
setwd("~/source_data/")
patients <- read_csv("patients.csv")
icddx <- read_csv("d_icd_diagnoses.csv")
dx <- read_csv("diagnoses_icd.csv")
admissions <- read_csv("admissions.csv")
chartlist <- read_csv("d_items.csv")
rx <- read_csv("prescriptions.csv")


#Tidy Patient dataset with heart failure patients, distinct by patients
A <- dx %>% filter(icd_version==9 & substr(icd_code,1,3) %in%("428") & seq_num < 3|
                          icd_version==10 & substr(icd_code,1,3) %in%("I50") & seq_num < 3) %>% 
  select(subject_id, seq_num) %>%
  arrange(subject_id, seq_num) %>% 
  left_join(., patients) %>% 
  distinct(., subject_id, .keep_all = TRUE)

adm_dem <- admissions %>% select(subject_id, language, marital_status, ethnicity) %>% 
  group_by(subject_id) %>% slice(1)
# To find distinct number of subjects nrow(distinct(df,var1))

hf_dem <- A %>% left_join(.,adm_dem) 
hf_rx <- A %>%
    left_join(.,rx)

write_csv(hf_dem, "~/derived_data/hf_dem.csv")
write_csv(hf_rx, "~/derived_data/hf_rx.csv")

all_dem <- patients %>% left_join()
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


