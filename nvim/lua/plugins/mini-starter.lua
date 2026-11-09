vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces dashboard-nvim and alpha-nvim
-- (see lua/plugins/disabled/dashboard.lua and lua/plugins/disabled/alpha-dashboard.lua)
local starter = require("mini.starter")

-- Header -------------------------------------------------------------------

local logo = table.concat({
	"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
	"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
	"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
	"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
	"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
	"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}, "\n")

local function header()
	local hour = tonumber(os.date("%H"))
	local part = hour < 5 and "night" or hour < 12 and "morning" or hour < 18 and "afternoon" or "evening"
	local user = vim.env.USER or "there"
	return ("%s\n\nGood %s, %s"):format(logo, part, user)
end

-- Footer -------------------------------------------------------------------

local function footer()
	local v = vim.version()
	local ok, plugins = pcall(vim.pack.get)
	local count = ok and (" · %d plugins"):format(#plugins) or ""
	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
	return ("%s\nv%d.%d.%d%s · %s"):format(cwd, v.major, v.minor, v.patch, count, os.date("%a %d %b %Y"))
end

-- Items --------------------------------------------------------------------
-- Names are typed to filter (see query_updaters below), so give each action
-- a distinct first letter. Nothing may start with j/k (used for movement).

local function action(name, fn)
	return { name = name, action = fn, section = "Actions" }
end

local function telescope(picker)
	return function()
		require("telescope.builtin")[picker]()
	end
end

local items = {
	starter.sections.sessions(5, true),
	starter.sections.recent_files(5, true, false), -- files under cwd
	action("Find file", telescope("find_files")),
	action("Grep text", telescope("live_grep")),
	action("Old files (all)", telescope("oldfiles")),
	action("Explorer", function()
		require("mini.files").open()
	end),
	action("Lazygit", "LazyGit"),
	action("New file", "enew"),
	action("Config", function()
		vim.cmd.cd(vim.fn.stdpath("config"))
		require("telescope.builtin").find_files()
	end),
	action("Update plugins", function()
		vim.pack.update()
	end),
	action("Quit", "qall"),
}

-- Setup --------------------------------------------------------------------

starter.setup({
	header = header,
	footer = footer,
	items = items,
	content_hooks = {
		starter.gen_hook.adding_bullet("│ ", false),
		-- numbers on sessions/recent files only; actions keep letters
		starter.gen_hook.indexing("all", { "Actions" }),
		starter.gen_hook.padding(0, 1),
		starter.gen_hook.aligning("center", "center"),
	},
	-- j, k removed
	query_updaters = "abcdefghilmnopqrstuvwxyz0123456789_-.",
	silent = true,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniStarterOpened",
	callback = function(ev)
		vim.keymap.set("n", "j", function()
			starter.update_current_item("next")
		end, { buffer = ev.buf })
		vim.keymap.set("n", "k", function()
			starter.update_current_item("prev")
		end, { buffer = ev.buf })
	end,
})

-- Colors: make the starter blend with the colorscheme instead of the
-- default mini highlights. Re-applied on colorscheme change.
local function set_hl()
	local link = function(group, target)
		vim.api.nvim_set_hl(0, group, { link = target, default = false })
	end
	link("MiniStarterHeader", "Function")
	link("MiniStarterFooter", "Comment")
	link("MiniStarterSection", "Title")
	link("MiniStarterItemBullet", "Comment")
	link("MiniStarterItemPrefix", "Keyword")
	link("MiniStarterQuery", "IncSearch")
	link("MiniStarterCurrent", "CursorLine")
end
set_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
