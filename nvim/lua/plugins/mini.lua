vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- enhanced, a and i keybinds
require("mini.ai").setup()

-- autopairs
require("mini.pairs").setup()

-- access to surround keymaps sa, sd, sc etc
require("mini.surround").setup()

-- icons, replace nvim_web_devicons
require("mini.icons").setup()
-- serve icons to plugins that expect nvim-web-devicons (e.g. barbar)
MiniIcons.mock_nvim_web_devicons()

-- better jump capabilities
require("mini.jump").setup()
