vim.pack.add({
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
})

---@module 'blink.cmp'
---@type blink.cmp.Config
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	-- 'default' preset: C-space open, C-n/C-p select, C-e hide, C-k signature.
	-- See :h blink-cmp-config-keymap
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = { documentation = { auto_show = true } },

	sources = {
		-- obsidian.nvim completions arrive through "lsp" (its built-in LSP server)
		default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
		per_filetype = {
			markdown = { "lsp", "path", "buffer" },
		},
		providers = {
			-- words from the whole project via ripgrep, ranked below everything else
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				score_offset = -10,
			},
		},
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },
})
