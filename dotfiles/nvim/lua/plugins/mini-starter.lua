vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces dashboard-nvim and alpha-nvim
-- (see lua/plugins/disabled/dashboard.lua and lua/plugins/disabled/alpha-dashboard.lua)
require("mini.starter").setup()
