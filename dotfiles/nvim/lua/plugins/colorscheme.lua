vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })

catppuccin = require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = true,
	float = {
		transparent = true,
	},
	term_colors = true,
})
vim.cmd("colorscheme catppuccin ")
