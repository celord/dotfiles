# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh settings
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  github
  aws
  docker
  docker-compose
  node
  npm
  python
  pyenv
  rbenv
  asdf
  rust
  cargo
  tmux
  fzf
  ripgrep
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Source common shell configuration
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.extra ] && source ~/.extra

# Load NVM if it exists
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  . "$HOME/.nvm/nvm.sh"
  # This loads nvm bash_completion
  [ -s "$HOME/.nvm/bash_completion" ] && \. "$HOME/.nvm/bash_completion"
fi

# Load pyenv if it exists
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Load ASDF if it exists
if [ -f ~/.asdf/asdf.sh ]; then
  . ~/.asdf/asdf.sh
  . ~/.asdf/completions/asdf.bash
fi

# Load RVM if it exists
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  . "$HOME/.rvm/scripts/rvm"
fi

# FZF key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Initialize zoxide (if installed)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Powerlevel10k theme configuration (to customize prompt, run `p10k configure` or edit ~/.p10k.zsh)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zsh options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_GLOB
setopt CASE_GLOB

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 256 color support
export TERM="xterm-256color"

#PATH
export PATH=.opencode/bin:$PATH
