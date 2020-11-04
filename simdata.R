set.seed(0)
#Create variables
subject_id=(1:11981)
gender = rep(letters[1:2], each = 3)
anchor_age1 =
anchor_age2 =
language =
marital_status =
ethnicity =
Aspirin =
Statin =
Loop =
Insulin =
Nitroglycerin =
Warfarin =
death =
#rep(letters[1:2], each = 3)
#rnorm(n = 6, mean = 0, sd = 1)
#Create all_dem.csv
write_csv(sim_all_dem, "derived_data/all_dem.csv")
#Create hf_dem.csv
write_csv(sim_hf_dem, "derived_data/hf_dem.csv")
#Create hf_pred.csv
data.frame(subject_id, gender, anchor_age2, language, marital_status, ethnicity, Aspirin, Statin,
           Loop, Insulin, Nitroglycerin, Warfarin, death)
write_csv(sim_hf_pred, "derived_data/hf_pred.csv")