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

	-- Two states only, so one key creates a checkbox and the next press
	-- completes it: text -> "- [ ] text" -> "- [x] text" -> "- [ ] text".
	-- (The default order also cycles through ~, ! and >.)
	checkbox = {
		order = { " ", "x" },
		create_new = true,
	},
})

-- The fork sets <CR> (smart action: follow link / toggle checkbox / fold
-- heading), ]o / [o (next/prev link) by default. The old custom mappings
-- are re-created here as buffer-local keymaps on note buffers.
vim.api.nvim_create_autocmd("User", {
	pattern = "ObsidianNoteEnter",
	callback = function(ev)
		vim.keymap.set("n", "<leader>gf", "<Cmd>Obsidian follow_link<CR>", { buffer = ev.buf, desc = "Obsidian follow link" })
		vim.keymap.set("n", "<leader>ch", function()
			local blank = not vim.api.nvim_get_current_line():match("%S")
			vim.cmd("Obsidian toggle_checkbox")
			-- An empty "- [ ] " is not a task item to the markdown parser, so
			-- it stays raw text until it has content: go straight to typing it.
			if blank then
				vim.cmd("startinsert!")
			end
		end, { buffer = ev.buf, desc = "Obsidian create/complete checkbox" })
		-- Visual: ":" (not <Cmd>) so the selection is passed as a line range
		vim.keymap.set("x", "<leader>ch", ":Obsidian toggle_checkbox<CR>", { buffer = ev.buf, silent = true, desc = "Obsidian create/complete checkboxes" })
	end,
})
