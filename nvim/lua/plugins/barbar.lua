vim.pack.add({
	"https://github.com/romgrk/barbar.nvim",
})

require("barbar").setup({})

-- H/L instead of <Tab>/<S-Tab>: in most terminals <Tab> and <C-i> are the
-- same key, so mapping <Tab> would take away jumplist-forward.
vim.keymap.set("n", "L", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "H", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
