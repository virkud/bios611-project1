FROM rocker/verse
MAINTAINER Arti Virkud <virkud@mit.edu>
RUN R -e "install.packages('data.table')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('e1071')"
RUN R -e "install.packages('gridExtra')"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "rstudio:$linux_user_pwd" | chpasswd
RUN adduser rstudio sudo
RUN apt update -y && apt install -y\
        ne\
        sqlite3\
        texlive-latex-base