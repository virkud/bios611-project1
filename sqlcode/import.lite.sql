drop table if exists chart;
create table chart (subject_id INTEGER, hadm_id INTEGER, stay_id INTEGER, charttime TEXT, storetime TEXT, itemid INTEGER, value INTEGER, valuenum INTEGER, valueom TEXT, warning INTEGER);
.mode csv
.import chart.headless.csv chart
