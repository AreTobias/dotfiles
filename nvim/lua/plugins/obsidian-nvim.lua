vim.pack.add({
	{ src = "https://github.com/epwalsh/obsidian.nvim", version = "*" },
})

-- obsidian.nvim only ships nvim-cmp sources (cmp_obsidian, cmp_obsidian_new,
-- cmp_obsidian_tags). nvim-cmp itself is installed just to provide the
-- `cmp` module/registry these sources plug into; blink.cmp (via
-- blink.compat, see plugins/blink-cmp.lua) is what actually renders
-- completions in the UI. `cmp.setup()` is intentionally never called.
vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
})

require("obsidian").setup({
	workspaces = {
		{
			name = "Are Tobias Vault",
			path = "~/Documents/Obsidian/Are Tobias Vault",
		},
	},

	notes_subdir = "notes",
	daily_notes = {
		folder = "Notes/Daily",
		date_format = "%d-%m-%Y",
		default_tags = { "daily-notes " },
	},

	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["<leader>gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		-- Smart action depending on context, either follow link or toggle checkbox.
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
	},
	new_notes_location = "notes_subdir",
})
