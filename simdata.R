library(tidyverse)
set.seed(0)
#Create variables
subject_id=(1:11981)
gender = rep(c("M","F"), each = 5991)
anchor_age1 = round(rnorm(11981,40.94589,26.10265),0)
anchor_age2 = round(rnorm(11981,71.9793,13.6417),0)
language=rep(c("English","?"), each = 5991)
marital_status = rep(c("DIVORCED","MARRIED", "SINGLE", "WIDOWED",""), each = 3000)
ethnicity = rep(c("AMERICAN INDIAN/ALASKA NATIVE","ASIAN", "BLACK/AFRICAN AMERICAN",
                  "HISPANIC/LATINO","OTHER","UNABLE TO OBTAIN", "UNKNOWN",
                  "UNKNOWN"), each=2995)
Aspirin = rbinom(11981,1,0.8218)
Statin = rbinom(11981,1,0.78)
Loop = rbinom(11981,1,0.9144)
Insulin = rbinom(11981,1,0.6195)
Nitroglycerin = rbinom(11981,1,0.2805)
Warfarin = rbinom(11981,1,0.8218)
death = rbinom(11981,1,0.02863)
#rep(letters[1:2], each = 3)
#rnorm(n = 6, mean = 0, sd = 1)
#Create all_dem.csv
sim_all_dem <- data.frame(subject_id, gender=gender[1:11981], anchor_age=anchor_age1[1:11981])
write_csv(sim_all_dem, "derived_data/all_dem.csv")
#Create hf_dem.csv
sim_hf_dem <- data.frame(subject_id, gender=gender[1:11981], anchor_age=anchor_age2, 
                         language=language[1:11981], 
           marital_status=marital_status[1:11981], ethnicity=ethnicity[1:11981])
write_csv(sim_hf_dem, "derived_data/hf_dem.csv")
#Create hf_pred.csv
sim_hf_pred <- data.frame(subject_id, gender=gender[1:11981], anchor_age=anchor_age2, 
                          language=language[1:11981], marital_status=marital_status[1:11981], 
                          ethnicity= ethnicity[1:11981], Aspirin, Statin,
           Loop, Insulin, Nitroglycerin, Warfarin, death)
write_csv(sim_hf_pred, "derived_data/hf_pred.csv")