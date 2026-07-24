vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
})

vim.pack.add({
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})
vim.pack.add({
    'https://github.com/nvim-telescope/telescope.nvim', 
 })

-- dependencies = {
--
--     'nvim-lua/plenary.nvim',
--     -- optional but recommended
--     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
-- }
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Telescope find files"})
vim.keymap.set('n', '<leader>fp', builtin.live_grep, {desc = "Telescope live grep"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Telescope find buffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Telescope find help tags"})




