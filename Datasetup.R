library(tidyverse)

#loading datasets
patients <- read_csv("source_data/patients.csv")
#icddx <- read_csv("source_data/d_icd_diagnoses.csv")
dx <- read_csv("source_data/diagnoses_icd.csv")
admissions <- read_csv("source_data/admissions.csv")
#chartlist <- read_csv("source_data/d_items.csv")
rx <- read_csv("source_data/prescriptions.csv")


#Tidy Patient dataset with heart failure patients, distinct by patients
A <- dx %>% filter(icd_version==9 & substr(icd_code,1,3) %in%("428") & seq_num < 3|
                          icd_version==10 & substr(icd_code,1,3) %in%("I50") & seq_num < 3) %>% 
  select(subject_id, seq_num) %>%
  arrange(subject_id, seq_num) %>% 
  left_join(., patients) %>% 
  distinct(., subject_id, .keep_all = TRUE) %>% 
  select(-seq_num, -anchor_year, -anchor_year_group, -dod)

adm_dem <- admissions %>% select(subject_id, language, marital_status, ethnicity, deathtime) %>% 
  group_by(subject_id) %>% slice(1)
# To find distinct number of subjects nrow(distinct(df,var1))

hf_dem <- A %>% left_join(.,adm_dem)
write_csv(hf_dem, "derived_data/hf_dem.csv")

all_dem <- patients %>% left_join(.,adm_dem) %>% select(-anchor_year, -anchor_year_group, -dod)
write_csv(patients, "derived_data/all_dem.csv")

##Top medications
hf_rx <- A %>% left_join(.,rx)
write_csv(hf_rx, "derived_data/hf_rx.csv")
#top10_1 <- hf_rx %>% count(subject_id,drug)
# top10 <- top10_1 %>% select(-n) %>% dplyr::count(drug) %>% 
#   filter(n>3000)
##test <- hf_rx %>% filter(drug=="Acamprosate") %>% count(subject_id)
# statinlist <- hf_rx %>% filter(grepl('statin',drug)) %>% select(drug) %>% 
#   distinct(drug)
# loop <- hf_rx %>% filter(grepl('semide',drug)|grepl('bumeta',drug)) %>% select(drug) %>% 
#   distinct(drug)
hf_rx2 <- hf_rx %>% select(subject_id, drug) %>% group_by(subject_id) %>%
  mutate(Aspirin=if_else(drug=="Aspirin"|drug=="Aspirin EC",1,0),
         Statin=if_else(drug=="Atorvastatin"|drug=="Simvastatin"|
                          drug=="Pravastatin"|drug=="Rosuvastatin Calcium"|drug=="simvastatin"|
                          drug=="Lovastatin"|drug=="atorvastatin 40 mg"|drug=="Atorvastatin 40 mg"|
                          drug=="pravastatin"|drug=="rosuvastatin"|drug=="lovastatin"|
                          drug=="atorvastatin"|drug=="Rosuvastatin"|drug=="atorvastatin 40 mg capsule"|
                          drug=="Fluvastatin"|drug=="pitavastatin calcium"|drug=="Livalo (pitavastatin calcium)"|
                          drug=="INV-Atorvastatin"|drug=="*NF* Pentostatin",1,0),
         Loop=if_else(drug=="Furosemide"|drug=="Furosemide-Heart Failure"
                      |drug=="Torsemide"|drug=="Furosemide (Latex Free)"
                      |drug=="Furosemide Rapid Oral Densitization"|drug=="Furosemide 40mg/4mL 4mL VIAL"
                      |drug=="torsemide"|drug=="Furosemide 100mg/10mL 10mL VIAL"
                      |drug=="Furosemide 20mg/2mL 2mL VIAL"|drug=="furosemide"
                      |drug=="Furosemide in 0.9% Sodium Chloride"|drug=="Furosemide Desensitization",1,0),
         Insulin=if_else(drug=="Insulin",1,0),
         Nitroglycerin=if_else(drug=="Nitroglycerin",1,0),
         Warfarin=if_else(drug=="Warfarin",1,0))
hf_rx3 <- hf_rx2 %>% group_by(subject_id) %>% summarise(Asp=sum(Aspirin),
                                                        Sta=sum(Statin),
                                                        Lo=sum(Loop),
                                                        In=sum(Insulin),
                                                        Nitro=sum(Nitroglycerin),
                                                        Warf=sum(Warfarin))
hf_rx4 <- hf_rx3 %>% mutate(Aspirin=if_else(Asp>0,1,0),Statin=if_else(Sta>0,1,0),
                            Loop=if_else(Lo>0,1,0),Insulin=if_else(In>0,1,0),
                            Nitroglycerin=if_else(Nitro>0,1,0),Warfarin=if_else(Warf>0,1,0)) %>% 
  select(-Asp, -Sta, -Lo, -In, -Nitro, -Warf)
data <- hf_dem %>% left_join(.,hf_rx4) %>% mutate(death=if_else(is.na(deathtime),0,1)) %>% select(-deathtime)
write_csv(data, "derived_data/hf_pred.csv")

#This dataset was developed in sqlite using bash code (see sqlite)
#hfevents <- read_csv("derived_data/hfevents.csv") %>% select(-`hadm_id:1`, -`subject_id:1`)

#List of HF events
#hflist <- hfevents %>% select(itemid) %>% 
#  left_join(chartlist) %>% distinct(., itemid, .keep_all = TRUE) 

#ABPs1 <- hfevents %>% filter(itemid==220050) %>% group_by(subject_id, hadm_id) %>% 
#          select(-seq_num, -icd_code, -icd_version, -storetime, -stay_id, -`hadm_id:1`)
#top_n(ABPs1,10)




