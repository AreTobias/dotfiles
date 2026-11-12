vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces lualine.nvim
require("mini.statusline").setup({
	use_icons = true,
})
