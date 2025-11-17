FROM docker.io/rocq/rocq-prover:9.1-ocaml-4.14-flambda

RUN sudo apt-get update \
 && sudo apt-get install -y \
    vim-nox

RUN mkdir -p /home/rocq/.vim/pack/coq/start \
 && git clone https://github.com/sofia-rose/Coqtail.git /home/rocq/.vim/pack/coq/start/Coqtail \
 && vim +helptags\ /home/coq/.vim/pack/coq/start/Coqtail/doc +q

COPY vimrc /home/rocq/.vimrc
