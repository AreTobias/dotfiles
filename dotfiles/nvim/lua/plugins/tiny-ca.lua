vim.pack.add({
	"https://github.com/rachartier/tiny-code-action.nvim",
})

require("tiny-code-action").setup()
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
