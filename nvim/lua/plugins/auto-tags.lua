vim.pack.add({
	"https://github.com/windwp/nvim-ts-autotag",
})

-- Auto close/rename HTML/JSX tags (needs the html/tsx/javascript parsers,
-- installed in treesitter.lua)
require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
})
