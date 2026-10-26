vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces treesj (see lua/plugins/disabled/treesj.lua)
-- keep the old <leader>m toggle keymap instead of mini's default 'gS'
require("mini.splitjoin").setup({
	mappings = {
		toggle = "<leader>m",
		split = "",
		join = "",
	},
})
