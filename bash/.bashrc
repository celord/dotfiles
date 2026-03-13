# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Source common shell configuration
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.extra ] && source ~/.extra

# Bash specific options
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# Better history handling
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /opt/homebrew/etc/bash_completion ]; then
    . /opt/homebrew/etc/bash_completion
  fi
fi

# Prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '

# 256 color support
if [ "$TERM" = "xterm" ]; then
  export TERM="xterm-256color"
fi
