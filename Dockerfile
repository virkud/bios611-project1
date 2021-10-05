FROM rocker/verse
MAINTAINER Arti Virkud <virkud@mit.edu>
ARG linux_user_pwd
RUN R -e "install.packages(c('tidyverse','plotly','data.table','gbm','caret',\
'e1071', 'gridExtra', 'reshape', 'plyr', 'shiny'))"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "rstudio:$linux_user_pwd" | chpasswd
RUN adduser rstudio sudo
RUN apt update -y && apt install -y\
        ne\
        sqlite3\
	texlive-base\
	texlive-binaries\
        texlive-latex-base\
	texlive-latex-recommended\
	texlive-pictures\
        texlive-latex-extra\
	python3-pip

RUN pip3 install jupyter jupyterlab
RUN pip3 install numpy pandas sklearn plotnine matplotlib pandasql bokeh pymatch \
        scipy statsmodels seaborn
RUN R -e "install.packages(\"tinytex\"); tinytex::install_tinytex()"
