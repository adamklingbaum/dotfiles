-- Custom key bindings

local map = vim.keymap.set

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlight with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Quick save
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Fuzzy finder (fzf-lua)
map("n", "<leader>f", "<cmd>FzfLua files<CR>", { desc = "Find files" })
map("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>/", "<cmd>FzfLua live_grep<CR>", { desc = "Search in files" })
map("n", "<leader>r", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent files" })
