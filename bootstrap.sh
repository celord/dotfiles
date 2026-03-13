#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Directories
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME}"

# Stow packages to install
STOW_PACKAGES=(
  "bash"
  "zsh"
  "git"
  "tmux"
  "vim"
  "nvim"
  "alacritty"
  "kitty"
  "editor"
)

# Functions
print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_info() {
  echo -e "${YELLOW}ℹ${NC} $1"
}

# Check if running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
else
  print_error "Unsupported OS: $OSTYPE"
  exit 1
fi

print_info "Detected OS: $OS"

# Check if stow is installed
check_stow() {
  if ! command -v stow &> /dev/null; then
    print_info "stow not found, installing..."
    if [ "$OS" = "mac" ]; then
      brew install stow
    else
      sudo apt-get update && sudo apt-get install -y stow
    fi
    print_success "stow installed"
  else
    print_success "stow is already installed"
  fi
}

# Symlink dotfiles using stow
symlink_dotfiles() {
  print_info "Symlinking dotfiles with stow..."

  for package in "${STOW_PACKAGES[@]}"; do
    local package_dir="$DOTFILES_DIR/$package"
    
    if [ ! -d "$package_dir" ]; then
      print_info "Package directory not found: $package_dir, skipping..."
      continue
    fi

    # Use stow to symlink the package
    stow --dir="$DOTFILES_DIR" --target="$HOME_DIR" "$package"
    print_success "Symlinked package: $package"
  done
}

# Create necessary directories
create_directories() {
  print_info "Creating necessary directories..."

  local dirs=(
    "$HOME_DIR/.local/bin"
    "$HOME_DIR/.vim/backup"
    "$HOME_DIR/.vim/swap"
    "$HOME_DIR/.vim/undo"
    "$HOME_DIR/.nvim/backup"
    "$HOME_DIR/.nvim/swap"
    "$HOME_DIR/.nvim/undo"
    "$HOME_DIR/.config"
  )

  for dir in "${dirs[@]}"; do
    mkdir -p "$dir"
  done

  print_success "Directories created"
}

# Install Homebrew packages (macOS only)
install_homebrew_packages() {
  if [ "$OS" != "mac" ]; then
    print_info "Skipping Homebrew installation (not on macOS)"
    return
  fi

  print_info "Checking for Homebrew..."

  if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  print_info "Installing Homebrew packages..."

  local packages=(
    "git"
    "tmux"
    "vim"
    "neovim"
    "zsh"
    "bash"
    "python@3.11"
    "node"
    "nvm"
    "fzf"
    "ripgrep"
    "fd"
    "eza"
    "zoxide"
    "bat"
    "curl"
    "wget"
    "htop"
    "jq"
    "stow"
  )

  for package in "${packages[@]}"; do
    if brew list "$package" &>/dev/null; then
      print_success "$package is already installed"
    else
      print_info "Installing $package..."
      brew install "$package"
    fi
  done
}

# Install apt packages (Linux only)
install_apt_packages() {
  if [ "$OS" != "linux" ]; then
    print_info "Skipping apt installation (not on Linux)"
    return
  fi

  print_info "Updating package list..."
  sudo apt-get update

  print_info "Installing system packages..."

  local packages=(
    "build-essential"
    "git"
    "tmux"
    "vim"
    "neovim"
    "zsh"
    "python3"
    "python3-pip"
    "python3-venv"
    "nodejs"
    "npm"
    "curl"
    "wget"
    "htop"
    "jq"
    "fzf"
    "ripgrep"
    "fd-find"
    "bat"
    "default-jdk"
    "stow"
  )

  for package in "${packages[@]}"; do
    if dpkg -l | grep -q "^ii  $package"; then
      print_success "$package is already installed"
    else
      print_info "Installing $package..."
      sudo apt-get install -y "$package"
    fi
  done
}

# Install eza and zoxide (available on both systems)
install_eza_zoxide() {
  print_info "Installing eza and zoxide..."

  if [ "$OS" = "mac" ]; then
    # macOS: already installed via Homebrew above
    print_success "eza and zoxide installed via Homebrew"
  else
    # Linux: Install from GitHub releases or via cargo
    
    # Install eza
    if ! command -v eza &> /dev/null; then
      print_info "Installing eza..."
      
      # Try to install from source using cargo if available
      if command -v cargo &> /dev/null; then
        cargo install eza --locked
        print_success "eza installed via cargo"
      else
        # Try to download pre-built binary
        print_info "Downloading eza binary..."
        local eza_url="https://github.com/eza-community/eza/releases/latest"
        # Fallback: let user install manually
        print_error "eza not found. Please install from https://github.com/eza-community/eza"
      fi
    else
      print_success "eza is already installed"
    fi

    # Install zoxide
    if ! command -v zoxide &> /dev/null; then
      print_info "Installing zoxide..."
      
      if command -v cargo &> /dev/null; then
        cargo install zoxide --locked
        print_success "zoxide installed via cargo"
      else
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        print_success "zoxide installed"
      fi
    else
      print_success "zoxide is already installed"
    fi
  fi
}

# Set up git
setup_git() {
  print_info "Setting up git..."

  # Check if git user is not configured
  if ! git config --global user.name > /dev/null 2>&1; then
    print_info "Please enter your git user name:"
    read -r git_name
    git config --global user.name "$git_name"
    print_success "Git user name set to: $git_name"
  fi

  if ! git config --global user.email > /dev/null 2>&1; then
    print_info "Please enter your git email:"
    read -r git_email
    git config --global user.email "$git_email"
    print_success "Git email set to: $git_email"
  fi

  # Set gitignore
  git config --global core.excludesfile "$HOME_DIR/.gitignore_global"
  print_success "Global gitignore configured"
}

# Install Oh My Zsh
install_oh_my_zsh() {
  if [ -d "$HOME_DIR/.oh-my-zsh" ]; then
    print_success "Oh My Zsh is already installed"
    return
  fi

  print_info "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  print_success "Oh My Zsh installed"

  # Install plugins
  print_info "Installing Oh My Zsh plugins..."
  
  plugins_dir="$HOME_DIR/.oh-my-zsh/custom/plugins"
  mkdir -p "$plugins_dir"

  # zsh-autosuggestions
  if [ ! -d "$plugins_dir/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
    print_success "Installed zsh-autosuggestions"
  fi

  # zsh-syntax-highlighting
  if [ ! -d "$plugins_dir/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$plugins_dir/zsh-syntax-highlighting"
    print_success "Installed zsh-syntax-highlighting"
  fi

  # zsh-completions
  if [ ! -d "$plugins_dir/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions "$plugins_dir/zsh-completions"
    print_success "Installed zsh-completions"
  fi

  # cargo plugin
  if [ ! -d "$plugins_dir/cargo" ]; then
    mkdir -p "$plugins_dir/cargo"
    cat > "$plugins_dir/cargo/cargo.plugin.zsh" << 'EOF'
# Cargo plugin for oh-my-zsh
# Provides useful aliases and completions for Rust's Cargo package manager

# Aliases
alias ca='cargo'
alias caa='cargo add'
alias cab='cargo build'
alias cac='cargo check'
alias cach='cargo check --all-features'
alias cad='cargo doc'
alias caddo='cargo doc --open'
alias cai='cargo install'
alias cal='cargo clippy'
alias cam='cargo make'
alias canew='cargo new'
alias cap='cargo publish'
alias car='cargo run'
alias cars='cargo run --release'
alias cart='cargo test'
alias cartu='cargo test -- --test-threads=1'
alias caud='cargo update'

# Enable tab completion for cargo
if [[ -f ~/.cargo/env ]]; then
  source ~/.cargo/env
fi
EOF
    print_success "Installed cargo plugin"
  fi

  # ripgrep plugin
  if [ ! -d "$plugins_dir/ripgrep" ]; then
    mkdir -p "$plugins_dir/ripgrep"
    cat > "$plugins_dir/ripgrep/ripgrep.plugin.zsh" << 'EOF'
# Ripgrep plugin for oh-my-zsh
# Provides useful aliases for ripgrep (rg) - a fast grep alternative

# Aliases
alias rg='rg --color=auto'
alias rga='rg --hidden'
alias rgf='rg --files'
alias rgl='rg -l'
alias rgL='rg -L'
alias rgs='rg --smart-case'
alias rgw='rg --word-regexp'
alias rgx='rg --regexp'
alias rgc='rg --count'
alias rge='rg --engine=regex'
alias rgj='rg --json'

# Function to search with context
rgc_func() {
  rg -C "${1:-3}" "${2:-.}"
}

alias rgc_context='rgc_func'

# Enable ripgrep completion if available
if command -v rg &> /dev/null; then
  if [[ -f ~/.cargo/env ]]; then
    source ~/.cargo/env
  fi
fi
EOF
    print_success "Installed ripgrep plugin"
  fi

  # Install Powerlevel10k theme
  if [ ! -d "$HOME_DIR/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME_DIR/.oh-my-zsh/custom/themes/powerlevel10k"
    print_success "Installed Powerlevel10k theme"
  fi
}

# Create ~/.extra file if it doesn't exist
create_extra_file() {
  if [ ! -f "$HOME_DIR/.extra" ]; then
    cat > "$HOME_DIR/.extra" << 'EOF'
# ~/.extra is sourced by .bashrc, .bash_profile, and .zshrc
# Use this file for personal configurations that you don't want to commit to version control
# Examples:
# - Git credentials
# - Personal aliases
# - Local PATH modifications
# - Environment variables

# Git credentials example (uncomment and fill in):
# GIT_AUTHOR_NAME="Your Name"
# GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
# git config --global user.name "$GIT_AUTHOR_NAME"
# GIT_AUTHOR_EMAIL="your.email@example.com"
# GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
# git config --global user.email "$GIT_AUTHOR_EMAIL"

# Add custom aliases here:
# alias myalias="command"
EOF
    print_success "Created ~/.extra file"
  fi
}

# Main installation
main() {
  echo ""
  echo "════════════════════════════════════════"
  echo "     Dotfiles Installation Script       "
  echo "════════════════════════════════════════"
  echo ""

  # Ask for confirmation
  read -p "Continue with installation? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Installation cancelled"
    exit 1
  fi

  create_directories
  
  if [ "$OS" = "mac" ]; then
    install_homebrew_packages
  else
    install_apt_packages
  fi

  check_stow
  symlink_dotfiles
  create_extra_file
  install_eza_zoxide
  install_oh_my_zsh
  #setup_git

  # Ask about font installation
  echo ""
  read -p "Install fonts? (JetBrains Mono, FiraCode, Cascadia Code, Ubuntu) (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$DOTFILES_DIR/bin/install-fonts.sh" ]; then
      bash "$DOTFILES_DIR/bin/install-fonts.sh"
    fi
  fi

  echo ""
  echo "════════════════════════════════════════"
  print_success "Installation completed!"
  echo "════════════════════════════════════════"
  echo ""
  print_info "Next steps:"
  echo "  1. Edit ~/.extra with your personal configuration"
  echo "  2. Run: chsh -s /bin/zsh (to set zsh as default shell)"
  echo "  3. Restart your terminal or run: source ~/.zshrc"
  echo "  4. Configure p10k theme: p10k configure"
  echo "  5. (Optional) Install fonts: ~/dotfiles/bin/install-fonts.sh"
  echo ""
  print_info "Alacritty configuration:"
  echo "  - Using TOML format: ~/.config/alacritty/alacritty.toml"
  echo "  - Edit the config file to customize Alacritty settings"
  echo ""
}

main "$@"
