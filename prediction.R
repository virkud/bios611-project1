library(tidyverse)
library(dplyr)
#Setup datasets from Datasetup.R
hf_dem<- read_csv("derived_data/hf_dem.csv")
hf_rx<- read_csv("derived_data/hf_rx.csv")

#Top medications
top10_1 <- hf_rx %>% count(subject_id,drug)
top10 <- top10_1 %>% select(-n) %>% dplyr::count(drug) %>% 
  filter(n>3000)
#test <- hf_rx %>% filter(drug=="Acamprosate") %>% count(subject_id)
statinlist <- hf_rx %>% filter(grepl('statin',drug)) %>% select(drug) %>% 
  distinct(drug)
loop <- hf_rx %>% filter(grepl('semide',drug)|grepl('bumeta',drug)) %>% select(drug) %>% 
  distinct(drug)
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
data <- hf_dem %>% left_join(.,hf_rx4) %>% select(-dod) %>% mutate(death=if_else(deathtime=NA,1,0))