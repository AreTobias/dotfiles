vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
})

vim.pack.add({
	"https://github.com/williamboman/mason-lspconfig.nvim",
})

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
})

local mason = require("mason")
mason.setup({})

require("mason-lspconfig").setup({
	ensure_installed = {
		"stylua",
		"lua_ls",
		"ts_ls",
		"pyright",
		-- "emmet-ls",
		-- "emmet-language-server",
	},
	automat_installation = true,
})
-- return {
--   {
--     "mason-org/mason-lspconfig.nvim",
--     opts = {},
--     dependencies = {
--       { "mason-org/mason.nvim", opts = {} },
--       "neovim/nvim-lspconfig",
--     },
--   },
--   {
--     'williamboman/mason-lspconfig.nvim',
--     config = function()
--       require("mason-lspconfig").setup({
--         ensure_installed = {
--           "lua_ls",
--           "ts_ls",
--           "pyright",
--         },
--         automat_installation = true
--
--       })
--     end,
--   },
--   -- {
--   --   "neovim/nvim-lspconfig",
--   --   config = function()
--   --     local lspconfig = require("lspconfig")
--   --     lspconfig.lua_ls.setup({})
--   --     lspconfig.ts_ls.setup({})
--   --     lspconfig.pyright.setup({})
--   --   end,
--   -- }
-- }
