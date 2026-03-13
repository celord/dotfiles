# Font Configuration Guide

## Overview

This dotfiles configuration includes **Ubuntu Mono** as the default system font everywhere, with optional **Nerd Fonts** available for enhanced terminal and editor capabilities.

### What You Get

- **Default Font**: Ubuntu Mono (clean, system font, no special glyphs)
- **Optional Nerd Fonts**:
  - JetBrains Mono Nerd Font
  - FiraCode Nerd Font
  - Cascadia Code Nerd Font

## Quick Start

### Install Fonts

After running `bootstrap.sh`, install fonts with:

```bash
~/dotfiles/bin/install-fonts.sh
```

This interactive script allows you to:
1. Install individual Nerd Fonts
2. Install all fonts at once
3. Install Ubuntu fonts (system package)

### macOS Installation

On macOS, fonts are installed via **Homebrew**:

```bash
# Automatic (via bootstrap.sh)
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-cascadia-code-nerd-font
brew install --cask font-ubuntu
```

Fonts are installed to: `~/Library/Fonts/`

### Linux Installation

On Linux (Ubuntu/Debian), fonts are installed manually or via package manager:

```bash
# Ubuntu fonts via APT
sudo apt-get install fonts-ubuntu fonts-ubuntu-mono

# Nerd Fonts downloaded and installed to:
~/.local/share/fonts/

# Rebuild font cache
fc-cache -fv ~/.local/share/fonts/
```

## Font Comparison

| Font | Style | Ligatures | Nerd Font | Best For |
|------|-------|-----------|-----------|----------|
| **Ubuntu Mono** | Clean, Modern | No | No | Universal (default) |
| **JetBrains Mono** | Developer-focused | Yes | Available | IDEs, editors with icon support |
| **FiraCode** | Elegant | Yes | Available | Coding, readability |
| **Cascadia Code** | Modern | Yes | Available | Microsoft tools, PowerShell |

## Configuration Files

### Alacritty (`config/alacritty/alacritty.yml`)

Default configuration uses **Ubuntu Mono**:

```yaml
font:
  normal:
    family: "Ubuntu Mono"
    style: Regular
  bold:
    family: "Ubuntu Mono"
    style: Bold
  italic:
    family: "Ubuntu Mono"
    style: Italic
  bold_italic:
    family: "Ubuntu Mono"
    style: Bold Italic
  size: 12.0
```

To change to a Nerd Font:

```yaml
font:
  normal:
    family: "JetBrains Mono"  # or "FiraCode" or "Cascadia Code"
    style: "Regular"
  # ... rest of config
```

### Kitty (`config/kitty/kitty.conf`)

Default configuration uses **Ubuntu Mono**:

```ini
font_family      Ubuntu Mono
bold_font        Ubuntu Mono Bold
italic_font      Ubuntu Mono Italic
bold_italic_font Ubuntu Mono Bold Italic
font_size        12.0
```

To change fonts:

```ini
font_family      JetBrains Mono       # or "FiraCode" or "Cascadia Code"
bold_font        JetBrains Mono Bold
italic_font      JetBrains Mono Italic
bold_italic_font JetBrains Mono Bold Italic
```

### Neovim (`config/nvim/init.lua`)

GUI font configuration (for Neovim GUI):

```lua
-- Default: Ubuntu Mono
vim.opt.guifont = "Ubuntu Mono:h12"

-- To use a Nerd Font instead:
-- vim.opt.guifont = "JetBrains Mono:h12"
-- vim.opt.guifont = "FiraCode:h12"
-- vim.opt.guifont = "Cascadia Code:h12"
```

In terminal mode, Neovim uses your terminal's font settings.

## Font Installation Details

### Script: `~/dotfiles/bin/install-fonts.sh`

The installation script provides:

1. **Automatic download** from GitHub releases
2. **Platform detection** (macOS/Linux)
3. **Proper installation** to system/user font directories
4. **Font cache rebuild** on Linux
5. **Verification** of installed fonts

**Usage:**

```bash
# Interactive menu
~/dotfiles/bin/install-fonts.sh

# Or run with choices:
# 1 - JetBrains Mono Nerd Font
# 2 - FiraCode Nerd Font
# 3 - Cascadia Code Nerd Font
# 4 - Ubuntu Font
# 5 - All fonts
```

### Font Locations

**macOS:**
```
~/Library/Fonts/           # User fonts
/Library/Fonts/            # System fonts
```

**Linux:**
```
~/.local/share/fonts/      # User fonts
/usr/share/fonts/          # System fonts
```

## Customization

### Change All Fonts

To switch terminal and editor fonts globally:

1. **Edit Alacritty** (`~/.config/alacritty/alacritty.yml`):
   ```yaml
   font:
     normal:
       family: "JetBrains Mono"  # Change here
   ```

2. **Edit Kitty** (`~/.config/kitty/kitty.conf`):
   ```ini
   font_family JetBrains Mono    # Change here
   ```

3. **Edit Neovim GUI** (`~/.config/nvim/init.lua`):
   ```lua
   vim.opt.guifont = "JetBrains Mono:h12"  # Change here
   ```

### Per-Application

Different tools may have font settings:

**VS Code** (`~/.config/Code/User/settings.json`):
```json
{
  "editor.fontFamily": "Ubuntu Mono, 'JetBrains Mono', monospace",
  "editor.fontSize": 12,
  "editor.fontLigatures": true
}
```

**Bash/Zsh Terminal** (in terminal emulator settings, not in dotfiles)

## Font Features

### Ubuntu Mono
- ✓ Clean, system-standard font
- ✓ Excellent readability
- ✓ Pre-installed on Ubuntu
- ✗ No programming ligatures
- ✗ No special Nerd Font glyphs

### JetBrains Mono Nerd Font
- ✓ Designed by JetBrains for developers
- ✓ Excellent readability at small sizes
- ✓ Ligatures support
- ✓ Complete Nerd Font glyphs
- ✓ Looks great with status bars and themes

### FiraCode Nerd Font
- ✓ Beautiful programming ligatures
- ✓ Wide font family (thin to bold)
- ✓ Complete Nerd Font glyphs
- ✓ Popular in developer community
- ✗ Slightly thicker than others

### Cascadia Code Nerd Font
- ✓ Modern Microsoft font
- ✓ Programming ligatures
- ✓ Excellent in PowerShell/Terminal
- ✓ Complete Nerd Font glyphs
- ✓ Great kerning and spacing

## Troubleshooting

### Font Not Appearing

**Linux:**
```bash
# Rebuild font cache
fc-cache -fv ~/.local/share/fonts/

# List installed fonts
fc-list | grep "JetBrains\|Ubuntu\|FiraCode\|Cascadia"
```

**macOS:**
```bash
# Fonts should appear immediately in Font Book
# If not, restart the application
```

### Wrong Font Showing

1. Verify the font name matches exactly:
   ```bash
   # Linux
   fc-list | grep "Ubuntu Mono"
   
   # macOS (Font Book) or system preferences
   ```

2. Check configuration file syntax
3. Restart terminal/editor application
4. Clear application cache if needed

### Font Size Issues

If text is too small or large:

**Alacritty:**
```yaml
font:
  size: 14.0  # Increase from 12.0
```

**Kitty:**
```ini
font_size 14  # Increase from 12
```

**Neovim GUI:**
```lua
vim.opt.guifont = "Ubuntu Mono:h14"  # Change h12 to h14
```

## Terminal-Specific Setup

### Alacritty

1. Ensure font is installed
2. Edit `~/.config/alacritty/alacritty.yml`
3. Update `font.normal.family`
4. Restart Alacritty

### Kitty

1. Ensure font is installed
2. Edit `~/.config/kitty/kitty.conf`
3. Update `font_family` line
4. Restart Kitty

### GNOME Terminal

1. Right-click → Preferences
2. Go to "General" or "Profile" tab
3. Toggle "Use monospace font"
4. Select font from dropdown

### macOS Terminal / iTerm2

1. Terminal → Preferences → Profiles → Text
2. Click font dropdown
3. Select desired font and size

## Performance Considerations

- **Ubuntu Mono**: Lightweight, fast rendering
- **Nerd Fonts**: Slightly slower due to extended glyph set
- **All fonts**: Negligible performance impact on modern systems

## Font Rendering

### Antialiasing

Ubuntu comes with sensible defaults. If text looks blurry:

**Linux:**
```bash
# Check font.conf settings
~/.config/fontconfig/fonts.conf
```

**macOS:**
System Preferences → General → Font smoothing

### Ligatures

To disable ligatures in editors that support them:

**Alacritty:** (Not supported in current config)

**Neovim:**
```lua
-- Disable ligatures (if using a font that supports them)
vim.opt.guifont = "JetBrains Mono:h12:l"  -- Add :l flag
```

## Additional Resources

- [Nerd Fonts Official](https://www.nerdfonts.com/) - Font gallery and downloads
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) - Official JetBrains font
- [FiraCode](https://github.com/tonsky/FiraCode) - FiraCode repository
- [Cascadia Code](https://github.com/microsoft/cascadia-code) - Microsoft's font
- [Ubuntu Fonts](https://design.ubuntu.com/font/) - Ubuntu font project
- [Font Config Linux](https://wiki.archlinux.org/title/Font_configuration) - Advanced Linux font setup

## Summary

| Feature | Default | Available |
|---------|---------|-----------|
| **Default Font** | Ubuntu Mono | Yes |
| **Nerd Fonts** | Optional | JetBrains, FiraCode, Cascadia |
| **Installation** | Automatic (APT/Homebrew) | Via `install-fonts.sh` |
| **Customization** | Easy via config files | Per-app possible |
| **Performance** | Excellent | Good |
| **Special Glyphs** | No | Yes (with Nerd Fonts) |

---

**Note**: You can mix fonts - use Ubuntu Mono by default and Nerd Fonts where special glyphs are needed!
