-- Maintained community fork of obsidian.nvim (the original epwalsh repo is
-- archived). Completion for [[links]], #tags etc. comes from its built-in
-- in-process LSP, so blink.cmp picks it up through its normal "lsp" source —
-- no nvim-cmp / blink.compat shim needed.
vim.pack.add({
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
})

require("obsidian").setup({
	legacy_commands = false, -- use `:Obsidian <subcommand>` only

	workspaces = {
		{
			name = "Are Tobias Vault",
			path = "~/Documents/Obsidian/Are Tobias Vault",
		},
	},

	notes_subdir = "notes",
	new_notes_location = "notes_subdir",

	daily_notes = {
		folder = "Notes/Daily",
		date_format = "%d-%m-%Y", -- strftime format still supported
		default_tags = { "daily-notes" },
	},

	completion = {
		min_chars = 2,
	},
})

-- The fork sets <CR> (smart action: follow link / toggle checkbox / fold
-- heading), ]o / [o (next/prev link) by default. The old custom mappings
-- are re-created here as buffer-local keymaps on note buffers.
vim.api.nvim_create_autocmd("User", {
	pattern = "ObsidianNoteEnter",
	callback = function(ev)
		vim.keymap.set("n", "<leader>gf", "<Cmd>Obsidian follow_link<CR>", { buffer = ev.buf, desc = "Obsidian follow link" })
		vim.keymap.set("n", "<leader>ch", "<Cmd>Obsidian toggle_checkbox<CR>", { buffer = ev.buf, desc = "Obsidian toggle checkbox" })
	end,
})
