-- Build telescope-fzf-native's C sorter after install/update. Must be
-- registered before vim.pack.add() so it fires on first install too.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local spec, kind = ev.data.spec, ev.data.kind
		if spec.name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})

local telescope = require("telescope")
telescope.setup({
	extensions = {
		fzf = {}, -- defaults: fuzzy, smart_case, overrides generic + file sorters
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
pcall(telescope.load_extension, "fzf") -- no-op if the C build is missing
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fp", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope find help tags" })
