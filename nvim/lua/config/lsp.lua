-- LSP
local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local default_keymaps = {
	-- <leader>ca (code actions) is provided by plugins/tiny-ca.lua
	{ keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
	{ keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
	{ keys = "K", func = vim.lsp.buf.hover, desc = "Hover (alt)", has = "hoverProvider" },
	{ keys = "gd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
}

-- I use blink.cmp for completion, but you can use native completion too
local completion = vim.g.completion_mode or "blink" -- or 'native' for built-in completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buf = args.buf
		if client then
			-- Built-in completion
			if completion == "native" and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end

			-- Inlay hints
			if client:supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end

			if client:supports_method("textDocument/documentColor") then
				vim.lsp.document_color.enable(true, { bufnr = buf }, {
					style = "virtual",
				})
			end

			for _, km in ipairs(default_keymaps) do
				-- Only bind if there's no `has` requirement, or the server supports it
				if not km.has or client.server_capabilities[km.has] then
					vim.keymap.set(
						km.mode or "n",
						km.keys,
						km.func,
						{ buffer = buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
					)
				end
			end
		end
	end,
})

-- Servers started on matching filetypes (configs come from nvim-lspconfig's
-- lsp/*.lua, merged with any overrides in ~/.config/nvim/lsp/*.lua).
-- Install them with :Mason (the core set is ensured in plugins/mason.lua).
vim.lsp.enable({
	"ts_ls",
	"lua_ls",
	"pyright",
	"bashls",
	"yamlls",
	"jsonls",
	"html",
	"cssls",
	"jinja_lsp",
	-- Not installed yet; uncomment after `:MasonInstall <pkg>`:
	-- "gopls",         -- :MasonInstall gopls
	-- "rust_analyzer", -- :MasonInstall rust-analyzer
	-- "zls",           -- :MasonInstall zls
	-- "helm_ls",       -- :MasonInstall helm-ls
	-- "tailwindcss",   -- :MasonInstall tailwindcss-language-server
	-- "biome",         -- :MasonInstall biome
})

-- Extra servers on demand, e.g. vim.g.lsp_on_demands = { "eslint" }
if vim.g.lsp_on_demands then
	vim.lsp.enable(vim.g.lsp_on_demands)
end

vim.keymap.set("n", "<leader>th", function()
	local filter = { bufnr = 0 }
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
end, { desc = "Toggle inlay hints" })
