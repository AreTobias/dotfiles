vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

require("mason").setup({})

-- LSP servers (lspconfig names). Which servers actually *run* is decided in
-- config/lsp.lua via vim.lsp.enable(), so automatic_enable is off — that
-- keeps one source of truth and stops stray installs (e.g. pylsp) from
-- starting alongside pyright.
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"pyright",
		"bashls",
		"yamlls",
		"jsonls",
		"html",
		"cssls",
		"jinja_lsp",
	},
	automatic_enable = false,
})

-- Formatters/linters (Mason package names) used by conform.lua.
-- mason-lspconfig only handles LSP servers, so install these directly.
local tools = { "stylua", "ruff", "yamlfix" }
local registry = require("mason-registry")
registry.refresh(function()
	for _, name in ipairs(tools) do
		local ok, pkg = pcall(registry.get_package, name)
		if ok and not pkg:is_installed() then
			pkg:install()
		end
	end
end)
