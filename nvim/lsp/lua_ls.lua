-- ~/.config/nvim/lsp/lua_ls.lua
return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" }, -- Neovim uses LuaJIT
			diagnostics = { globals = { "vim" } }, -- Recognize 'vim' global
		},
	},
}
