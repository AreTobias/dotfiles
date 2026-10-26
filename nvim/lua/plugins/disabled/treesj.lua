vim.pack.add({
	"https://github.com/Wansmer/treesj",
})

local treesj = require("treesj").setup()

vim.keymap.set("n", "<leader>m", treesj.toggle)
