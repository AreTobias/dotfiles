vim.pack.add({
  "https://github.com/nvim-mini/mini.icons",
})

vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
})
vim.pack.add({
  "https://github.com/goolord/alpha-nvim",
})
-- dependencies = { 'nvim-mini/mini.icons' },
-- dependencies = { 'nvim-tree/nvim-web-devicons' },

config = function()
  local startify = require("alpha.themes.startify")
  -- available: devicons, mini, default is mini
  -- if provider not loaded and enabled is true, it will try to use another provider
  startify.file_icons.provider = "devicons"
  require("alpha").setup(
    startify.config
  )
end
