vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces lualine.nvim (see lua/plugins/disabled/lualine.lua)
require("mini.statusline").setup({
	use_icons = true,
})
