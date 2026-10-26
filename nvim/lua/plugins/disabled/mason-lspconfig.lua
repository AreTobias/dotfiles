vim.pack.add({
    "https://github.com/mason-org/mason-lspconfig.nvim",
)}
require('mason-lspconfig').setup()
--     opts = {},
--     dependencies = {
--       { "mason-org/mason.nvim", opts = {} },
--       "neovim/nvim-lspconfig",
--     },
--
--   {
--     src = 'williamboman/mason-lspconfig.nvim',
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

