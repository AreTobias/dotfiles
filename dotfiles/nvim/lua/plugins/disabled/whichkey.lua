vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

local wkey = require("which-key")
wkey.setup({})

vim.keymap.set("n", "<leader>?", function()
	wkey.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
