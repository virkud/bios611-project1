# handy aliases for working with the docker file
# and doing other stuff
alias bu='docker build . -t p1-env --build-arg linux_user_pwd=yougotthis'
alias dr='docker run -v `pwd`:/home/rstudio -p 8787:8787 -e PASSWORD=yougotthis -t p1-env'
alias hc='docker run -p 8711:8000 -v `pwd`:/host -it p1-env hovercraft /host/slides.rst'
alias hcb='docker run -v `pwd`:/host -it p1-env hovercraft /host/slides.rst /host/html_presentation'
alias py='docker run -p 8765:8765 -v `pwd`:/home/rstudio -it p1-env sudo -H -u rstudio /bin/bash -c "cd ~/; jupyter lab --ip 0.0.0.0 --port 8765"'

alias r='docker run -v `pwd`:/home/rstudio -e PASSWORD=yougotthis -it p1-env sudo -H -u rstudio /bin/bash -c "cd ~/; R"'
alias b='docker run -v `pwd`:/home/rstudio -e PASSWORD=yougotthis -it p1-env sudo -H -u rstudio /bin/bash -c "cd ~/; /bin/bash"'

alias g1='ssh-agent bash'
alias g2='ssh-add ~/storage/example-keys/id_rsa'
alias g3='git config --global user.email "avirkud@unc.edu"'
alias g4='git config --global user.name "Arti Virkud"'

start_shiny(){
    docker run -p $2:$2 -v `pwd`:/home/rstudio -e PASSWORD=yougotthis -it l17 sudo -H -u rstudio /bin/bash -c "cd ~/; PORT=$2 make $1"
}