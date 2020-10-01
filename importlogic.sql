DROP TABLE if exists chart;
CREATE TABLE chart (subject_id INTEGER,hadm_id INTEGER, stay_id INTEGER,
          charttime TEXT, storetime TEXT, itemid INTEGER, value INTEGER, valuenum INTEGER,
           valueuom TEXT, warning INTEGER);
  
.mode csv
.import file.headless.csv chart