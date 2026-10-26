vim.pack.add({
	"https://github.com/b0o/SchemaStore.nvim",
})

-- Merged into nvim-lspconfig's lsp/jsonls.lua; enabled in config/lsp.lua
vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
