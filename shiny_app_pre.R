library(tidyverse)
#stats <- data %>% select(-name, -alignment) %>% names();
rx <- read_csv("derived_data/hf_rx.csv")
top10_1 <- rx %>% count(subject_id,drug)
top10_2 <- top10_1 %>% select(-n) %>% dplyr::count(drug) %>% 
  filter(n>5000)
stats <- rx %>% right_join(.,top10_2) %>% select(subject_id, hadm_id, gender, drug) %>% unique()
app <- stats %>% group_by(subject_id, drug, gender) %>% count()
write_csv(app, "derived_data/s_app.csv")