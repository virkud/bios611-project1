install.packages(R.utils)
library(tidyverse)

chartevents <- read_csv("/home/rstudio/data/icu/chartevents.csv.gz")

# write uncompressed data
d_icd_diagnoses %>% write_csv("/home/rstudio/data/hosp/d_icd_diagnoses.csv")