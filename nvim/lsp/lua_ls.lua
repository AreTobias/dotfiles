-- ~/.config/nvim/lsp/lua_ls.lua
return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" }, -- Neovim uses LuaJIT
			workspace = {
				checkThirdParty = false,
				-- Neovim runtime (vim.api, vim.lsp, ...) and vim.uv types
				library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
			},
		},
	},
}
