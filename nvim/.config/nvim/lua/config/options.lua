-- Core vim options

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Clipboard (use system clipboard)
opt.clipboard = "unnamedplus"

-- Undo persistence
opt.undofile = true

-- Mouse support
opt.mouse = "a"

-- UI
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8

-- Misc
opt.wrap = false
opt.updatetime = 250
opt.timeoutlen = 300
