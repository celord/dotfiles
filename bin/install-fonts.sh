#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Font directories
FONTS_DIR="${HOME}/.local/share/fonts"
MACOS_FONTS_DIR="${HOME}/Library/Fonts"

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_info() {
  echo -e "${YELLOW}ℹ${NC} $1"
}

print_header() {
  echo -e "${BLUE}━━━ $1 ━━━${NC}"
}

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="mac"
  FONT_DIR="$MACOS_FONTS_DIR"
else
  OS="linux"
  FONT_DIR="$FONTS_DIR"
fi

# Create font directories
mkdir -p "$FONT_DIR"
mkdir -p "$FONTS_DIR" # Also create Linux fonts dir on all platforms

# Download and install Nerd Fonts
install_nerd_font() {
  local font_name=$1
  local font_url=$2
  local font_file=$3

  print_info "Downloading $font_name..."

  # Create temp directory
  local temp_dir=$(mktemp -d)
  cd "$temp_dir" || exit 1

  # Download font
  if command -v curl &> /dev/null; then
    curl -fsSL "$font_url" -o "$font_file"
  elif command -v wget &> /dev/null; then
    wget -q "$font_url" -O "$font_file"
  else
    print_error "Neither curl nor wget found. Cannot download fonts."
    rm -rf "$temp_dir"
    return 1
  fi

  # Extract font
  if [[ "$font_file" == *.zip ]]; then
    unzip -q "$font_file"
  elif [[ "$font_file" == *.tar.gz ]]; then
    tar -xzf "$font_file"
  fi

  # Install fonts
  if [ "$OS" = "mac" ]; then
    # Copy all font files to macOS fonts directory
    find . -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} "$FONT_DIR/" \;
    print_success "Installed $font_name on macOS"
  else
    # Copy all font files to Linux fonts directory
    find . -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} "$FONT_DIR/" \;
    print_success "Installed $font_name on Linux"
  fi

  # Cleanup
  cd - > /dev/null
  rm -rf "$temp_dir"
}

# Install JetBrains Mono Nerd Font
install_jetbrains_mono() {
  local version="3.0.0"
  local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/JetBrainsMono.zip"
  install_nerd_font "JetBrains Mono Nerd Font" "$url" "JetBrainsMono.zip"
}

# Install FiraCode Nerd Font
install_firacode() {
  local version="6.2"
  local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/FiraCode.zip"
  install_nerd_font "FiraCode Nerd Font" "$url" "FiraCode.zip"
}

# Install Cascadia Code Nerd Font
install_cascadia() {
  local version="3.0.0"
  local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/CascadiaCode.zip"
  install_nerd_font "Cascadia Code Nerd Font" "$url" "CascadiaCode.zip"
}

# Rebuild font cache on Linux
rebuild_font_cache() {
  if [ "$OS" = "linux" ] && command -v fc-cache &> /dev/null; then
    print_info "Rebuilding font cache..."
    fc-cache -fv "$FONTS_DIR" > /dev/null 2>&1 || true
    print_success "Font cache rebuilt"
  fi
}

# Install Ubuntu font on Linux
install_ubuntu_font() {
  if [ "$OS" = "linux" ]; then
    if command -v apt-get &> /dev/null; then
      print_info "Installing Ubuntu fonts..."
      sudo apt-get install -y fonts-ubuntu fonts-ubuntu-mono > /dev/null 2>&1 || true
      print_success "Ubuntu fonts installed"
    fi
  fi
}

# Install fonts via Homebrew on macOS
install_fonts_homebrew() {
  if [ "$OS" = "mac" ]; then
    if command -v brew &> /dev/null; then
      print_info "Installing fonts via Homebrew..."
      
      # Tap cask-fonts if not already tapped
      if ! brew tap | grep -q "homebrew-cask/font"; then
        brew tap homebrew/cask-fonts
      fi

      # Install fonts
      brew install --cask font-jetbrains-mono-nerd-font || true
      brew install --cask font-fira-code-nerd-font || true
      brew install --cask font-cascadia-code-nerd-font || true
      brew install --cask font-ubuntu || true

      print_success "Fonts installed via Homebrew"
    fi
  fi
}

# List installed fonts
list_installed_fonts() {
  print_header "Installed Fonts"
  
  if [ "$OS" = "linux" ]; then
    if command -v fc-list &> /dev/null; then
      print_info "Fonts containing 'Ubuntu', 'JetBrains', 'FiraCode', or 'Cascadia':"
      echo ""
      fc-list : family | grep -iE "Ubuntu|JetBrains|FiraCode|Cascadia" | sort | uniq || true
    fi
  elif [ "$OS" = "mac" ]; then
    print_info "Fonts in $FONT_DIR:"
    ls -1 "$FONT_DIR" | grep -iE "Ubuntu|JetBrains|FiraCode|Cascadia" || true
  fi
}

# Main installation
main() {
  echo ""
  print_header "Nerd Fonts Installation"
  echo ""

  # Ask which fonts to install
  print_info "Available fonts to install:"
  echo "  1) JetBrains Mono Nerd Font"
  echo "  2) FiraCode Nerd Font"
  echo "  3) Cascadia Code Nerd Font"
  echo "  4) Ubuntu Font (default system font)"
  echo "  5) All fonts"
  echo ""

  read -p "Enter your choice (1-5, or 'a' for all): " choice

  case $choice in
    1) install_jetbrains_mono ;;
    2) install_firacode ;;
    3) install_cascadia ;;
    4) install_ubuntu_font ;;
    5|a|A)
      print_info "Installing all fonts..."
      install_ubuntu_font
      
      if [ "$OS" = "mac" ]; then
        install_fonts_homebrew
      else
        install_jetbrains_mono
        install_firacode
        install_cascadia
      fi
      ;;
    *)
      print_error "Invalid choice"
      exit 1
      ;;
  esac

  # Rebuild font cache on Linux
  rebuild_font_cache

  # List installed fonts
  list_installed_fonts

  echo ""
  print_header "Font Installation Complete"
  echo ""
  echo "Next steps:"
  echo "  1. Update your terminal/editor settings to use these fonts"
  echo "  2. For Alacritty: Edit ~/.config/alacritty/alacritty.yml"
  echo "  3. For Neovim: Edit ~/.config/nvim/init.lua"
  echo "  4. For VS Code: Update settings.json with desired font"
  echo ""
  
  if [ "$OS" = "linux" ]; then
    echo "Font directories:"
    echo "  • System fonts: /usr/share/fonts"
    echo "  • User fonts: $FONTS_DIR"
  else
    echo "Font directory: $FONT_DIR"
  fi

  echo ""
}

main "$@"
