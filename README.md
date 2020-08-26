Bios 611 Project
================
Superhero Analytics
-------------------
This repo will eventually contain an analysis of Heart Failure patients in the ICU.

Using This Project
------------------

You will need Docker. You will need to be able to run docker as your user.


	> docker build . -t project1-env
	> docker run -v 'pwd':/home/rstudio -p 8787:8787\
		 -e PASSWORD=<yourpassword> -t project1-env