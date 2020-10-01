SQL code for BIOS 611-Project 1
===============================
This folder contains all the relevant sqlite3 code to manipulate the MIMIC-IV tables
into a table that contains all the patients with heart failure. To use this code,
the docker file must be run (to install sqlite) and chartevents.csv and
diagnoses_icd.csv must be in the same folder. Chartevents.csv is roughly ~22MB in size,
so make sure you have sufficient space to open and run the following code. 

First, you want to import the chart events data using import.lite.sql.
	sqlite3 events.db < import.lite.sql

Then you want to import the diagnosis data using import.dxicd.sql.
	sqlite3 events.db < import.dxicid.sql

Finally, you will run the sql code that merges these two datatsets for only patients
with a heart failure diagnosis. 
	sqlite3 events.db < hf.sql

Save this file as hfevents.csv for the main analysis.

The rest of the data manipulation is conducted in R using tidyverse in Datasetup.R
(located in the above directory).