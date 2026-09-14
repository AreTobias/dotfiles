vim.pack.add({
	"https://github.com/b0o/SchemaStore.nvim",
})

require("lspconfig").jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
