Bios 611-Project 1
================
Analysis of MIMIC-4
-------------------
This repo will eventually contain an analysis of Heart Failure patients in the ICU. This analysis will be conducted in Rstudio, for which the script is contained in Analysis.R.

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

For example, to build figures relating to the distribution of ICU visits due to heart failure over race compaired to all ICU visits, enter via Docker or with Rstudio and say:

	> make figures/hfvicu_race_cmpr.png

Dataset
-------
This project uses MIMIC-IV. This is a retrospectively collected datasource containing ICU and EHR data. You can obtain more information on it here: physionet.org/content/mimiciv/0.4/.

You may need to request a DUA to access this data.

Preliminary figures
-------------------

Primary questions
-----------------

Proposal
--------

Completition criterion
----------------------
