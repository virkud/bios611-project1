Bios 611-Project 1
================

Proposal: Analysis of MIMIC-4
-----------------------------

### Introduction
Heart failure is a debilitating disease that effects about 6.2 million adults in the US every year, 
according to the CDC. While the risk factors for heart failure are known and have been extensively 
studied, the prevalence of known risk factors are evolving. Additionally, new medications and therapies 
are being introduced all the time. These changes mean that our understanding of what predicts heart 
failure may be changing as well. So what are the *current* drivers of mortality in this population? 

### Dataset
This project uses MIMIC-IV. This is a retrospectively collected datasource containing electronic
health record (EHR) data from Beth Israel Deaconess Medical Center (BIDMC). These data are deidentified
records with information on patient experiences in the ICU. This analysis will use a subset of 
this data restricted to patients who are admitted with a heart failure diagnosis. MIMIC-IV is
an excellent data source to examine the risk factors predicting heart failure since physicians
have more and more been using and relying on their respective EHR systems to document patient diagnostics
and histories. Additionally, this data system has access to all the lab results and procedures that
patients received during their hospitalization.

The data are fairly large, particularly the chart events, so make sure you have sufficient storage
to manipulate this data. You can obtain more information on the data here: 
https://physionet.org/content/mimiciv/0.4/ 
https://mimic-iv.mit.edu/docs/overview/concepts/

Citations:
Johnson, A., Bulgarelli, L., Pollard, T., Horng, S., Celi, L. A., & Mark, R. (2020). MIMIC-IV (version 0.4). 
PhysioNet. https://doi.org/10.13026/a3wn-hq05.

Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). 
PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex 
physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220.

You will need to request a DUA to access this data. 

Given the size of the data, the primary heart failure dataset will be set-up using sqlite, which is
included in the Dockerfile. Further details are included in the sqlcode folder.
This analysis will be conducted in Rstudio, for which the script is contained in Analysis.R.

### Preliminary figures
Age and sex among heart failure ICU patients compared with all other ICU patients.
![](assets/all_age_sex.png)

The above figure shows that there are a range of patients captures in this dataset, but most
are older adults.

![](assets/hf_age_sex.png)

Most heart failure patients are older adults. Many more individuals in the highest age group (91) are female
than male.

Using This Project
------------------
You will need Docker. You will need to be able to run docker as your current user.

	> docker build . -t project1-env
	> docker run -v 'pwd':/home/rstudio -p 8787:8787\
		 -e PASSWORD=<yourpassword> -t project1-env

Then connect to the mahcine on port 8787.

Makefile
--------
The Makefile included in this repository will help get a feel of the project. 

For example, to build figures relating to the distribution of ICU visits due to heart failure over 
age and gender, enter via Docker or with Rstudio and say:

	> make figures/hf_age_sex.png

Primary questions
-----------------
The primary question is to identify and characterize features predictive of mortality in heart failure 
patients. This will be conducted in two steps: 

1) We will examine a variety of features (demographic information, medications, and lab results) to 
identify predictors of mortality in this patient poulation using logistic regression, LASSO, 
and Elastic Net.

2) We will characterize propensity scores for medications identified in the first step using logistic 
regression and Random forest. 


Completition criterion
----------------------
I want to fully understand the heart failure patients in this dataset and identify a preferred method 
to identify predictors and to calculate propensity scores.