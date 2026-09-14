vim.pack.add({
    "https://github.com/stevearc/oil.nvim",

})



local oil = require("oil")

oil.setup({


})
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
