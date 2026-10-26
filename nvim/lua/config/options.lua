vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window focus (C-h/j/k/l) is handled by plugins/tmux-navigator.lua
