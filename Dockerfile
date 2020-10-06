FROM rocker/verse
MAINTAINER Arti Virkud <avirkud@unc.edu>
RUN apt update -y && apt install -y \
	ne\
	sqlite3
RUN R -e "install.packages('data.table')"

