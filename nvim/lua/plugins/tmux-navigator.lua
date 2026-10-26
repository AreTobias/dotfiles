vim.pack.add({
	"https://github.com/christoomey/vim-tmux-navigator",
})

-- Neovim half of vim-tmux-navigator (tmux half lives in ~/.tmux.conf).
-- C-h/j/k/l move between nvim splits, then fall through to tmux panes.
vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { desc = "Move focus left (nvim/tmux)" })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { desc = "Move focus down (nvim/tmux)" })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { desc = "Move focus up (nvim/tmux)" })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { desc = "Move focus right (nvim/tmux)" })
vim.keymap.set("n", "<C-Left>", "<Cmd>TmuxNavigateLeft<CR>", { desc = "Move focus left (nvim/tmux)" })
vim.keymap.set("n", "<C-Right>", "<Cmd>TmuxNavigateRight<CR>", { desc = "Move focus right (nvim/tmux)" })
