. ~/.bashrc

export PATH="${PWD}/bin:${PATH}"

source <(kind completion bash)

source <(kubectl completion bash)

source <(helm completion bash)


NORMAL="\[\033[00m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"
BLUE="\[\033[01;34m\]"
MAGENTA="\[\e[1;35m\]"
CYAN="\[\e[1;36m\]"
NL="
"

__kube_ps1()
{
  CONTEXT="$(kubectl config current-context)"
  if [ -n "${CONTEXT}" ]; then
    echo "${CONTEXT}"
  fi
}

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose

export PROMPT_COMMAND='__git_ps1 "${MAGENTA}k8s: $(__kube_ps1)${NL}${GREEN}❤\u❤ ${YELLOW}\w${CYAN}" "${NL}${NORMAL}\D{%F %T} ${MAGENTA}λx. ${NORMAL}" " %s "'
