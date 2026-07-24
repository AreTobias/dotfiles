vim.pack.add{ { src="https://github.com/catppuccin/nvim", name = "catppuccin" }}


catppuccin = require("catppuccin").setup({
  flavour = "macchiato",
})
vim.cmd("colorscheme catppuccin ")



