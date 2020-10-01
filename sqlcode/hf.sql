.mode csv
.header on
create table hfevents as
select a.*, b.*
from dx as a
left join chart as b on a.subject_id=b.subject_id and a.hadm_id=b.hadm_id
where seq_num<3 AND (icd_version = 9 and substr(icd_code,1,3) in ("428")) OR
(icd_version=10 and substr(icd_code,1,3) in ("I50"));
