FROM docker.io/coqorg/coq:8.20-ocaml-4.14-flambda

RUN sudo apt-get update \
 && sudo apt-get install -y \
    vim-nox

RUN mkdir -p /home/coq/.vim/pack/coq/start \
 && git clone https://github.com/sofia-rose/Coqtail.git /home/coq/.vim/pack/coq/start/Coqtail \
 && vim +helptags\ /home/coq/.vim/pack/coq/start/Coqtail/doc +q

COPY vimrc /home/coq/.vimrc
