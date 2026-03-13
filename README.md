# Dotfiles

A comprehensive dotfiles configuration for Linux and macOS users who develop in Python and JavaScript.

This repository contains carefully curated configuration files for a modern development environment, inspired by best practices from [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) and [semanser/dotfiles](https://github.com/semanser/dotfiles).

## What's Included

### Shell Configuration
- **`.bashrc`** - Bash configuration with aliases and functions
- **`.bash_profile`** - Login shell setup with version manager initialization
- **`.zshrc`** - Zsh configuration with Oh My Zsh integration and Powerlevel10k theme
- **`.aliases`** - Common shell aliases for git, development, and system commands
- **`.exports`** - Environment variables for development tools (Python, Node)
- **`.functions`** - Useful shell functions (extract, venv, git helpers, etc.)

### Editors & Tools
- **`.editorconfig`** - Unified code style across editors (Python, JS, Bash)
- **`.vimrc`** - Vim configuration with sensible defaults and keybindings
- **`config/nvim/init.lua`** - Neovim Lua configuration with LSP-ready settings

### Git
- **`.gitconfig`** - Git configuration with helpful aliases and settings
- **`.gitignore_global`** - Global .gitignore for Python, Node, and IDEs

### Terminal & Multiplexing
- **`.tmux.conf`** - Tmux configuration with vim-like navigation
- **`config/alacritty/alacritty.yml`** - Alacritty terminal config with Ubuntu Mono font
- **`config/kitty/kitty.conf`** - Kitty terminal config with Ubuntu Mono font

### Fonts
- **Ubuntu Mono** - Default system font (everywhere)
- **Optional Nerd Fonts** - JetBrains Mono, FiraCode, Cascadia Code
- **`bin/install-fonts.sh`** - Font installation script
- **`FONTS.md`** - Comprehensive font configuration guide

### Development Environments

#### Python
- **`python/requirements-dev.txt`** - Common development dependencies
- **`python/pyproject.toml`** - Black, isort, mypy, and pytest configuration

#### JavaScript/TypeScript
- **`config/tsconfig.json`** - TypeScript configuration
- **`config/.prettierrc`** - Prettier code formatter config
- **`config/.eslintrc.json`** - ESLint configuration
- **`config/.prettierignore`** - Prettier ignore patterns

## Quick Start

### Prerequisites
- Git
- Bash or Zsh
- One of: Homebrew (macOS) or apt (Linux)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the bootstrap script:
```bash
./bootstrap.sh
```

The bootstrap script will:
- Create necessary directories
- Symlink configuration files
- Install package managers and common tools
- Set up Oh My Zsh with themes and plugins
- Configure git
- Optionally install fonts (Ubuntu Mono default, Nerd Fonts optional)

3. Edit `~/.extra` with your personal configuration:
```bash
nano ~/.extra
```

4. Set Zsh as your default shell:
```bash
chsh -s /bin/zsh
```

5. Restart your terminal and configure Powerlevel10k:
```bash
p10k configure
```

6. (Optional) Install additional fonts:
```bash
~/dotfiles/bin/install-fonts.sh
```

For detailed font configuration, see [FONTS.md](FONTS.md).

## Customization

### ~/.extra
Create or edit `~/.extra` in your home directory for personal configurations that shouldn't be version controlled:
- Git credentials
- Personal aliases
- Local PATH modifications
- Secret environment variables

Example:
```bash
# Git credentials
GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="your.email@example.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

### ~/.path
Create `~/.path` to add custom paths to your `$PATH` variable:
```bash
export PATH="$HOME/.custom/bin:$PATH"
export PATH="/usr/local/opt/custom/bin:$PATH"
```

## Platform-Specific Notes

### macOS
The bootstrap script will install and configure:
- Homebrew package manager
- Common development tools via Homebrew
- System defaults optimized for development

### Linux
The bootstrap script will install and configure:
- APT packages (Ubuntu/Debian)
- Common development tools

## What Gets Installed

### Package Managers & Build Tools
- Git, Curl, Wget
- Homebrew (macOS) / APT (Linux)
- NVM (Node Version Manager)
- pyenv (Python Version Manager)
- ASDF (Multiple version manager)

### Development Tools
- Python 3
- Node.js & npm
- Neovim, Vim
- Tmux
- Zsh & Oh My Zsh

### Utilities
- FZF (fuzzy finder)
- Ripgrep (fast search)
- fd (fast find)
- bat (cat replacement)
- exa (ls replacement)
- jq (JSON processor)
- htop (process monitor)

## Shell Features

### Aliases
```bash
g          # git
gst        # git status
gco        # git checkout
gd         # git diff
glog       # git log graph

l          # ls -la
c          # clear
py         # python3
venv       # create/activate virtual environment
```

### Functions
```bash
mkd <dir>          # Create directory and cd into it
extract <file>     # Extract common archive formats
venv               # Create/activate Python virtual env
pgrep <name>       # Search for process
pkill <name>       # Kill process by name
git_branch         # Get current git branch
git_status         # Get git status count
use_node <version> # Switch Node version
```

## Git Aliases

```bash
git st              # Short status
git ll              # Log oneline
git lg              # Log graph
git amend           # Amend last commit
git clean-local     # Delete merged local branches
git clean-remote    # Delete merged remote branches
git who             # Show contributors
```

## Configuration Files by Language

### Python
- Targets: Python 3.8+
- Tools: Black (formatter), isort (imports), mypy (type check), pytest (testing)
- Location: `python/`

### JavaScript/TypeScript
- Targets: ES2020+
- Tools: Prettier (formatter), ESLint (linter), TypeScript
- Location: `config/`

## Editors Supported

- **Vim** - via `.vimrc`
- **Neovim** - via `config/nvim/init.lua`
- **VS Code** - respects `.editorconfig`
- **JetBrains IDEs** - respects `.editorconfig`
- **Terminal editors** - all shell config applies

## Uninstallation

To remove dotfiles, delete the symlinks:
```bash
rm ~/.bashrc ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.gitconfig ~/.aliases ~/.exports ~/.functions ~/.editorconfig
rm ~/.config/alacritty ~/.config/nvim
```

Or restore from backups if they exist:
```bash
for f in ~/.*.backup; do mv "$f" "${f%.backup}"; done
```

## Troubleshooting

### Zsh plugins not loading
- Ensure Oh My Zsh is installed: `~/.oh-my-zsh`
- Check that plugins directory exists: `~/.oh-my-zsh/custom/plugins`
- Restart terminal: `source ~/.zshrc`

### Git config not applying
- Verify symlink: `ls -l ~/.gitconfig`
- Check user config: `git config --list --global`
- Set manually if needed: `git config --global user.name "Your Name"`

### Terminal colors look wrong
- Check terminal supports 256 colors: `echo $TERM`
- Install a patched font for Powerlevel10k
- Try: `export TERM=xterm-256color`

### Neovim init.lua not loading
- Check config location: `~/.config/nvim/init.lua`
- Verify Neovim version: `nvim --version`
- Check for errors: `nvim --noplugin`

## Credits

This dotfiles configuration builds on the excellent work of:
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) - macOS defaults and shell setup
- [semanser](https://github.com/semanser/dotfiles) - Modern terminal setup with Neovim and Tmux

## License

MIT License - Feel free to fork, modify, and use for your own setup!

## Contributing

Improvements and suggestions are welcome! Please consider:
1. Testing changes on both macOS and Linux
2. Keeping configurations language-agnostic where possible
3. Adding comments to explain non-obvious settings
4. Updating documentation for new additions

## Additional Resources

- [EditorConfig](https://editorconfig.org/) - Unified coding styles
- [Oh My Zsh](https://ohmyz.sh/) - Zsh framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- [Neovim](https://neovim.io/) - Modern Vim
- [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer

---

**Warning:** Review all configuration files before using. Don't blindly apply settings without understanding them. Use at your own risk!
