# ~/.bash_profile is executed for interactive login shells

# Load ~/.bashrc if it exists
[ -f ~/.bashrc ] && source ~/.bashrc

# On macOS, set up PATH for Homebrew
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load NVM if it exists
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  . "$HOME/.nvm/nvm.sh"
fi

# Load RVM if it exists
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  . "$HOME/.rvm/scripts/rvm"
fi

# Load pyenv if it exists
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# Load ASDF if it exists
if [ -f ~/.asdf/asdf.sh ]; then
  . ~/.asdf/asdf.sh
fi
