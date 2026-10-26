vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

vim.keymap.set("n", "j", "<C-n>")
vim.keymap.set("n", "k", "<C-p>")

-- replaces dashboard-nvim and alpha-nvim
-- (see lua/plugins/disabled/dashboard.lua and lua/plugins/disabled/alpha-dashboard.lua)
require("mini.starter").setup({
	-- j, k removed
	query_updaters = "abcdefghilmnopqrstuvwxyz0123456789_-.",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniStarterOpened",
	callback = function(ev)
		local starter = require("mini.starter")
		vim.keymap.set("n", "j", function()
			starter.update_current_item("next")
		end, { buffer = ev.buf })
		vim.keymap.set("n", "k", function()
			starter.update_current_item("prev")
		end, { buffer = ev.buf })
	end,
})
