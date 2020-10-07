FROM rocker/verse
MAINTAINER Arti Virkud <avirkud@unc.edu>
RUN R -e "install.packages('data.table')"
RUN R -e "install.packages('gbm')"
RUN apt update -y && apt install -y \
	ne\
	sqlite3\
	texlive-latex-base

