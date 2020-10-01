drop table if exists dx;
create table dx (
subject_id INTEGER,
hadm_id INTEGER,
seq_num INTEGER,
icd_code TEXT,
icd_version INTEGER
);
.mode csv
.import dxicd.headless.csv dx
