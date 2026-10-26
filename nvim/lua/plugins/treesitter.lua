vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").install({
	"lua",
	"vim",
	"vimdoc",
	"markdown",
	"markdown_inline",
	"bash",
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if pcall(vim.treesitter.start, args.buf) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

-- require("nvim-treesitter.configs").setup({
-- 	ensure_installed = { "python", "lua", "bash", "markdown", "markdown_inline" },
-- 	highlight = {
-- 		enable = true,
-- 	},
-- })
