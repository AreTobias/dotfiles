vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- enhanced, a and i keybinds
require("mini.ai").setup()

-- autopairs: only auto-close when the cursor is NOT right before text, so
-- typing ( or " in front of an existing word inserts just one character.
-- Pairs when the next char is whitespace, line end (\n), a closing bracket,
-- or , ; : — otherwise inserts the single char.
local before_ok = "[%s\n%)%]%},;:]"
require("mini.pairs").setup({
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" .. before_ok },
		["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" .. before_ok },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" .. before_ok },
		-- quotes also don't pair right after a letter/digit, so a closing quote
		-- typed at the end of a word stays single
		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^%w\\]" .. before_ok, register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%w\\]" .. before_ok, register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^%w\\]" .. before_ok, register = { cr = false } },
	},
})

-- access to surround keymaps sa, sd, sc etc
require("mini.surround").setup()

-- icons, replace nvim_web_devicons
require("mini.icons").setup()
-- serve icons to plugins that expect nvim-web-devicons (e.g. barbar)
MiniIcons.mock_nvim_web_devicons()

-- better jump capabilities
require("mini.jump").setup()
