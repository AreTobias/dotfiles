vim.pack.add( {
	"https://github.com/romgrk/barbar.nvim",
})

local barbar = require("barbar")
barbar.setup()
vim.keymap.set('n', '<TAB>', "<Cmd>BufferNext<CR>")
vim.keymap.set('n', '<S-TAB>', "<Cmd>BufferPrevious<CR>")
vim.keymap.set('n', '<leader>x', "<Cmd>BufferClose<CR>")
-- vim.keymap.set('n', 'C-h', "<Cmd>BufferMovePrevious<CR>"),
-- vim.keymap.set('n', 'C-l', "<Cmd>BufferMoveNext<CR>"),
