vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces gitsigns.nvim (see lua/plugins/disabled/gitsigns.lua)
-- note: mini.diff only covers diff signs + hunk actions, not gitsigns'
-- current_line_blame feature.
require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "┃", change = "┃", delete = "_" },
	},
})
