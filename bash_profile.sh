### Unicode characters
lightning_char="`printf '\xE2\x9A\xA1'`"
checked_char="`printf '\xE2\x9C\x94'`"
asterix_char="`printf '\xE2\x9C\xB1'`"
arrow_char="`printf '\xE2\x9E\xA4'`"
curve_nw_char="`printf '\xE2\x95\xAD'`"
curve_sw_char="`printf '\xE2\x95\xB0'`"
### Colours
RED="\[\033[0;31m\]"
YELLOW="\[\033[1;33m\]"
BROWN="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_GRAY="\[\033[0;37m\]"
DARK_GRAY="\[\033[1;30m\]"
WHITE="\[\033[1;37m\]"
COLOR_NONE="\[\e[0m\]"
### Variables to create PS1
BRANCH=""
PROMPT_SYMBOL="\$"
 
# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}
function get_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
function set_git_branch {
  git_status="$(git status 2> /dev/null)"
 
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
    state_symbol="${checked_char}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
    state_symbol="${lightning_char}"
  else
    state="${RED}"
    state_symbol="${asterix_char}"
  fi
 
  BRANCH="${BLUE}$(get_git_branch)${COLOR_NONE} ${state}${state_symbol}${COLOR_NONE}"
}
# Set the full bash prompt.
function set_bash_prompt () {
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi
  
  # Set the bash prompt variable.
  export PS1="${RED}${arrow_char}${COLOR_NONE} ${DARK_GRAY}\W${COLOR_NONE}${BRANCH} \u${PROMPT_SYMBOL} "
}
# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
