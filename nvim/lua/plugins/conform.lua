vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- ruff replaces isort + black: sort imports, then format
		python = { "ruff_organize_imports", "ruff_format" },
		yaml = { "yamlfix" },
	},
	formatters = {
		yamlfix = {
			env = {
				YAMLFIX_SEQUENCE_STYLE = "block_style",
				YAMLFIX_WHITELINES = "1",
				-- Keep quotes as written (e.g. GitLab CI `if:` rules and scripts)
				YAMLFIX_PRESERVE_QUOTES = "true",
			},
		},
	},
	-- yamlfix has a slow (Python) startup, hence the generous timeout
	format_on_save = function()
		if vim.g.disable_autoformat then
			return
		end
		return { timeout_ms = 2000, lsp_format = "fallback" }
	end,
})

vim.keymap.set("n", "<leader>tf", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	vim.notify("Format on save " .. (vim.g.disable_autoformat and "off" or "on"))
end, { desc = "Toggle format on save" })
