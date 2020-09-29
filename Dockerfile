FROM rocker/verse
MAINTAINER Arti Virkud <avirkud@unc.edu>
RUN apt update -y && apt install -y sqlite3
RUN R -e "install.packages('data.table', 'gridExtra', 'XML', 'reshape2', 'plyr', 'RSQLite')"

