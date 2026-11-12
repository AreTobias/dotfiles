-- Each plugin module is loaded through `load()` instead of a bare `require()`
-- so that one plugin failing to set up (e.g. a missing path, a bad option)
-- can't abort every module listed after it.
local function load(name)
	local ok, err = pcall(require, name)
	if not ok then
		vim.notify(("[plugins] failed to load %s: %s"):format(name, err), vim.log.levels.ERROR)
	end
end

-- mini.nvim (core: mini.ai, mini.pairs, mini.surround, mini.icons, mini.jump)
--
load("plugins.mini")
load("plugins.tmux-navigator")
load("plugins.mini-statusline")
load("plugins.mini-starter")
load("plugins.mini-files")
load("plugins.mini-splitjoin")
load("plugins.mini-clue")
load("plugins.mini-diff")
load("plugins.mini-comment")
load("plugins.mini-indentscope")
load("plugins.mini-sessions")

-- Navigation
--
load("plugins.telescope")
load("plugins.harpoon")

load("plugins.colorscheme")
load("plugins.conform")
load("plugins.nvim-hlslens")

load("plugins.barbar")

load("plugins.treesitter")
load("plugins.mason")
load("plugins.schemastore")
load("plugins.modicator")
load("plugins.noice")
load("plugins.auto-tags")
load("plugins.obsidian-nvim")
load("plugins.render-markdown")
load("plugins.markdown-preview")
load("plugins.tabbout")
load("plugins.tiny-ca")
load("plugins.lazygit")

-- LSP / Completion
--
load("plugins.blink-cmp")
