-- (mapleader is set in init.lua, before anything else loads)

vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.o.breakindent = true

-- Files / persistence: swapfile is off, so persistent undo is the safety net
vim.o.swapfile = false
vim.o.undofile = true
vim.o.confirm = true -- ask to save instead of failing on :q

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true -- case-sensitive only when the pattern has a capital
vim.o.inccommand = "split" -- live preview of :s substitutions

-- UI
vim.o.signcolumn = "yes" -- no text shift when mini.diff/diagnostic signs appear
vim.o.cursorline = true -- also required by modicator.nvim
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.showmode = false -- mini.statusline shows the mode
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.linebreak = true -- wrap at word boundaries
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.winborder = "rounded" -- borders on all floating windows (0.11+)
vim.o.mouse = "a"

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300 -- matches mini.clue's popup delay

-- System clipboard (scheduled to keep it off the startup path)
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Diagnostics (virtual_text is off by default since 0.11)
vim.diagnostic.config({
	virtual_text = { spacing = 2, prefix = "●" },
	severity_sort = true,
	float = { source = "if_many" },
	underline = true,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window focus (C-h/j/k/l) is handled by plugins/tmux-navigator.lua
