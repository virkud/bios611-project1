FROM rocker/verse
MAINTAINER Arti Virkud <avirkud@unc.edu>
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('data.table')"
RUN R -e "install.packages('gridExtra')"
RUN R -e "install.packages('XML')"
RUN R -e "install.packages('reshape2')"
RUN R -e "install.packages('plyr')"