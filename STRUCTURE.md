# Dotfiles Directory Structure

## Overview
Complete dotfiles configuration for Python and JavaScript developers on Linux and macOS.

```
dotfiles/
├── Root Configuration Files (Dotfiles)
│   ├── .aliases                 # Shell aliases (git, dev tools, system)
│   ├── .bash_profile            # Bash login shell configuration
│   ├── .bashrc                  # Bash interactive shell configuration
│   ├── .editorconfig            # Unified editor settings (EditorConfig)
│   ├── .exports                 # Environment variables (PATH, LANG, etc.)
│   ├── .functions               # Reusable shell functions
│   ├── .gitconfig               # Git configuration and aliases
│   ├── .gitignore_global        # Global git ignore patterns
│   ├── .tmux.conf               # Tmux multiplexer configuration
│   ├── .vimrc                   # Vim configuration
│   └── .zshrc                   # Zsh shell configuration
│
├── config/                      # Application configurations
│   ├── .eslintrc.json           # ESLint configuration (JS/TS linting)
│   ├── .prettierignore          # Prettier ignore patterns
│   ├── .prettierrc              # Prettier code formatter config
│   ├── tsconfig.json            # TypeScript configuration
│   │
│   ├── alacritty/
│   │   └── alacritty.yml        # Alacritty terminal config (Ubuntu Mono)
│   │
│   ├── kitty/
│   │   └── kitty.conf           # Kitty terminal config (Ubuntu Mono)
│   │
│   └── nvim/
│       └── init.lua             # Neovim Lua configuration
│
├── python/                      # Python-specific configurations
│   ├── pyproject.toml           # Python project config (Black, isort, mypy, pytest)
│   └── requirements-dev.txt     # Python development dependencies
│
├── bin/                         # Custom executable scripts
│   └── install-fonts.sh         # Font installation script (Nerd Fonts)
│
├── bash/                        # Bash-specific configs (placeholder)
├── zsh/                         # Zsh-specific configs (placeholder)
├── tmux/                        # Tmux-specific configs (placeholder)
├── git/                         # Git-specific configs (placeholder)
│
├── bootstrap.sh                 # Main installation/setup script
├── README.md                    # Full documentation
├── FONTS.md                     # Font configuration guide
├── STRUCTURE.md                 # This file
└── .gitignore                   # Git ignore for dotfiles repo
```

## Configuration Files Details

### Shell Configuration (`.bashrc`, `.zshrc`, `.bash_profile`)
- Sources `.exports`, `.aliases`, `.functions` in order
- Initializes version managers (NVM, pyenv, ASDF, RVM)
- Sets up shell-specific features (completion, prompt, history)
- Provides 256-color terminal support

### Environment Variables (`.exports`)
- Python: `PYTHONUNBUFFERED`, `PYTHONDONTWRITEBYTECODE`
- Node: `NODE_ENV`
- FZF: `FZF_DEFAULT_COMMAND`, `FZF_CTRL_T_COMMAND`, `FZF_ALT_C_COMMAND`
- PATH configuration for Homebrew, local bin, npm, cargo

### Aliases (`.aliases`)
- **Git**: `g`, `ga`, `gc`, `gp`, `gl`, `gst`, `gd`, `gb`, `gco`, `glog`
- **File ops**: `l`, `la`, `ll`, `mkdir`, `cp`, `mv`, `rm`
- **Development**: `py`, `pip`, `npm`, `yarn`, `nvim`, `vim`
- **Network**: `ip`, `localip`, `ips`
- **Package managers**: `brew`, `apt`, `npm`, `yarn`

### Functions (`.functions`)
- `mkd()` - Create directory and enter it
- `extract()` - Extract archives (tar, zip, rar, 7z, etc.)
- `pgrep()` / `pkill()` - Process search and kill
- `git_branch()` - Get current branch
- `venv()` - Python virtual environment helper
- `use_node()` - Node version switcher
- `command_exists()` - Check if command exists

### Git Configuration (`.gitconfig`)
- Helpful git aliases for workflow
- Sensible defaults (push strategy, auto-stash on rebase)
- Merge conflict handling with vimdiff
- Diff algorithm (histogram) for better output
- Automatic cleanup of deleted remote refs

### Git Ignore (`.gitignore_global`)
- Python: `__pycache__`, `*.pyc`, `venv/`, `.pytest_cache/`
- JavaScript: `node_modules/`, `dist/`, `.eslintcache`
- IDE: `.vscode/`, `.idea/`, `*.iml`
- OS: `.DS_Store`, `Thumbs.db`
- Environment: `.env`, `.env.local`

### Editor Config (`.editorconfig`)
- Python: 4 spaces, max line 88
- JS/TS: 2 spaces
- YAML: 2 spaces
- JSON: 2 spaces
- Universal: UTF-8, LF line endings

### Vim Configuration (`.vimrc`)
- Line numbers (relative and absolute)
- Syntax highlighting
- Smart indentation
- Search highlighting (ignorecase + smartcase)
- Persistent undo/backup/swap
- Window navigation (C-hjkl)
- Leader key mapping (space)
- Language-specific indentation

### Neovim Configuration (`config/nvim/init.lua`)
- Lua-based configuration
- Modern defaults for terminal UI
- LSP-ready setup
- Same keybindings as Vim
- Auto-directory creation for undo/backup/swap

### Tmux Configuration (`.tmux.conf`)
- Prefix: `Ctrl+Space`
- Vim-like pane navigation (`hjkl`)
- Mouse support enabled
- 50,000 line history
- Status bar with time and session info
- Pane splitting with current path preservation

### Alacritty Configuration (`config/alacritty/alacritty.yml`)
- Font: **Ubuntu Mono** (default system font)
- Alternative fonts: JetBrains Mono, FiraCode, Cascadia Code (via Nerd Fonts)
- Colors: VS Code Dark theme
- Mouse support
- 10,000 line scrollback
- Key bindings for copy/paste, zoom, new window

### Kitty Configuration (`config/kitty/kitty.conf`)
- Font: **Ubuntu Mono** (default system font)
- Alternative fonts: JetBrains Mono, FiraCode, Cascadia Code (via Nerd Fonts)
- Colors: VS Code Dark theme
- Tab bar with powerline style
- Mouse support, 10,000 line scrollback
- Key bindings for common operations

### TypeScript Configuration (`config/tsconfig.json`)
- Target: ES2020
- Module: ESNext
- Strict mode enabled
- Declaration maps
- Source maps
- No unused variables or parameters

### ESLint Configuration (`config/.eslintrc.json`)
- Recommends: eslint:recommended, @typescript-eslint/recommended
- Import sorting and organization
- No console.log warnings (allow warn/error)
- Prettier integration
- React detection

### Prettier Configuration (`config/.prettierrc`)
- Print width: 88
- Tab width: 2
- Single quotes
- Trailing commas: ES5
- Semicolons: true
- Line ending: LF

### Python Configuration (`python/pyproject.toml`)
- Black: 88 line length, Python 3.8+
- isort: Black-compatible profile
- mypy: Type checking with ignore missing imports
- pytest: Test discovery and reporting
- Coverage: Source mapping with exclusions

## Bootstrap Script Features

The `bootstrap.sh` script automates:
1. **Directory Creation** - vim, nvim, local/bin directories
2. **Symlink Setup** - All dotfiles linked from home directory
3. **Config Symlinks** - Alacritty, Neovim, Kitty, and other configs
4. **Package Installation**:
   - **macOS**: Homebrew + 20+ tools
   - **Linux**: APT packages + 20+ tools
5. **Oh My Zsh** - Installation + 2 plugins + Powerlevel10k theme
6. **Git Setup** - Configure user name and email
7. **Font Installation** - Optional: Nerd Fonts (JetBrains, FiraCode, Cascadia)
8. **File Backups** - Existing configs backed up with `.backup` suffix

## Installation Steps

```bash
# 1. Clone repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run bootstrap
./bootstrap.sh

# 3. Configure personal settings
nano ~/.extra

# 4. Set default shell
chsh -s /bin/zsh

# 5. Restart terminal and configure p10k
p10k configure

# 6. (Optional) Install fonts
~/dotfiles/bin/install-fonts.sh
```

For detailed font configuration and usage, see [FONTS.md](FONTS.md).

## Language Support

### Python
- Version managers: pyenv, ASDF
- Tools: pip, virtualenv, black, pytest, mypy
- IDE support: EditorConfig, Neovim LSP

### JavaScript/TypeScript
- Version managers: NVM, ASDF
- Tools: npm, yarn, prettier, eslint
- Frameworks: React, Node.js compatible
- IDE support: EditorConfig, ESLint, Prettier

## Customization Points

### ~/.extra
For personal/secret configurations:
```bash
GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_EMAIL="your.email@example.com"
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_COMMITTER_EMAIL"
```

### ~/.path
For custom PATH additions:
```bash
export PATH="/custom/bin:$PATH"
```

### Language-Specific
- Copy configs to project root and customize
- Override in `.extra` without version control

## Platform Detection

- **macOS**: Uses Homebrew, includes .macos defaults (optional)
- **Linux**: Uses APT (Debian/Ubuntu), includes apt packages

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Plugins not loading | Restart shell: `source ~/.zshrc` |
| Colors wrong | Check TERM: `echo $TERM` |
| Git config not applying | Verify symlink: `ls -l ~/.gitconfig` |
| Neovim no theme | Install plugin manager (lazy.nvim/packer) |
| Tmux won't start | Check syntax: `tmux source-file ~/.tmux.conf` |

## Files Generated During Installation

```
~/.oh-my-zsh/                     # Oh My Zsh framework
~/.vim/backup/, undo/, swap/      # Vim backup directories
~/.nvim/backup/, undo/, swap/     # Neovim backup directories
~/.config/alacritty/              # Alacritty symlink
~/.config/kitty/                  # Kitty symlink
~/.config/nvim/                   # Neovim symlink
~/.local/share/fonts/             # User fonts (Linux)
~/Library/Fonts/                  # User fonts (macOS)
~/.local/bin/                     # Local bin directory
~/.extra                          # Personal config file
```

## Font Support

**Default Font**: Ubuntu Mono (system font)
**Optional Nerd Fonts**:
- JetBrains Mono Nerd Font
- FiraCode Nerd Font
- Cascadia Code Nerd Font

Font installation script: `bin/install-fonts.sh`
Font configuration guide: `FONTS.md`

## Total Configuration Lines

- Shell configs: ~400 lines
- Editor configs: ~350 lines (including Kitty)
- Git configs: ~150 lines
- Bootstrap script: ~375 lines (with font support)
- Font installation script: ~250 lines
- Documentation: ~500 lines (including FONTS.md)
- **Total: ~2000 lines** of configuration

## Version Requirements

- Bash 3.0+
- Zsh 4.3.0+
- Vim 7.0+ / Neovim 0.4+
- Tmux 3.0+
- Python 3.8+
- Node 14+

---

**Note**: This is a reference guide. Check individual config files for detailed comments and settings.
