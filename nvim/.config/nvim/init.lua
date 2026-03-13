-- Neovim init.lua configuration
-- This is the main Neovim configuration file

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Font Configuration
-- Default: Ubuntu Mono (system font, no special chars)
-- Alternative Nerd Fonts (install with ~/dotfiles/bin/install-fonts.sh):
--   - "JetBrains Mono" - JetBrains Mono Nerd Font
--   - "FiraCode" - FiraCode Nerd Font
--   - "Cascadia Code" - Cascadia Code Nerd Font
-- Guifont is used by GUI versions of Neovim (not in terminal mode)
vim.opt.guifont = "Ubuntu Mono:h12"

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = '88'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.undofile = true
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Backup and swap
vim.opt.backupdir = vim.fn.expand('~/.nvim/backup//')
vim.opt.undodir = vim.fn.expand('~/.nvim/undo//')
vim.opt.directory = vim.fn.expand('~/.nvim/swap//')

-- Key mappings
local keymap = vim.keymap.set

-- Navigate between windows
keymap('n', '<C-h>', '<C-w>h', { noremap = true })
keymap('n', '<C-j>', '<C-w>j', { noremap = true })
keymap('n', '<C-k>', '<C-w>k', { noremap = true })
keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Buffer navigation
keymap('n', '<leader>n', ':bnext<CR>', { noremap = true })
keymap('n', '<leader>p', ':bprev<CR>', { noremap = true })
keymap('n', '<leader>d', ':bdelete<CR>', { noremap = true })

-- Save and exit
keymap('n', '<leader>s', ':w<CR>', { noremap = true })
keymap('n', '<leader>q', ':q<CR>', { noremap = true })

-- Clear search highlighting
keymap('n', '<leader>h', ':noh<CR>', { noremap = true })

-- Toggle relative numbers
keymap('n', '<leader>r', ':set relativenumber!<CR>', { noremap = true })

-- Fast escape
keymap('i', 'jk', '<Esc>', { noremap = true })

-- Create directories if they don't exist
local function ensure_dir_exists(path)
  local expanded = vim.fn.expand(path)
  if vim.fn.isdirectory(expanded) == 0 then
    vim.fn.mkdir(expanded, 'p')
  end
end

ensure_dir_exists('~/.nvim/backup')
ensure_dir_exists('~/.nvim/undo')
ensure_dir_exists('~/.nvim/swap')

-- Auto commands for language-specific settings
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('LanguageSettings', { clear = true })

autocmd('FileType', {
  group = 'LanguageSettings',
  pattern = 'python',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd('FileType', {
  group = 'LanguageSettings',
  pattern = { 'javascript', 'typescript', 'yaml', 'json' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Optional: lazy loading plugin manager (Packer or Lazy.nvim)
-- Uncomment and install if you want plugin support
-- require('plugins')
