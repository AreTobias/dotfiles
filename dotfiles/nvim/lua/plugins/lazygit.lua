vim.pack.add({
	"https://github.com/kdheepak/lazygit.nvim",
})

-- lazygit.nvim is configured via vim.g.* and exposes :LazyGit directly,
-- no setup() call. plenary.nvim is already installed (see telescope.lua)
-- so let it use that for the floating window border.
vim.g.lazygit_floating_window_use_plenary = 1

vim.keymap.set("n", "<leader>gg", "<Cmd>LazyGit<CR>", { desc = "Open LazyGit" })
