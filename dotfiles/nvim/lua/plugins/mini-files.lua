vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

-- replaces oil.nvim, oil-git-status.nvim and neo-tree.nvim
-- (see lua/plugins/disabled/oil.lua, disabled/oil-gitstatus.lua, disabled/neo-tree.lua)
local minifiles = require("mini.files")
minifiles.setup()

-- mini.files only binds go_in/go_out to 'l'/'h' by default, not <CR>/'-'.
-- Add those too so navigation feels like oil.nvim/neo-tree.
-- <CR> uses close_on_file = true (like the default 'L'/go_in_plus mapping)
-- so opening a file also closes the explorer overlay, instead of plain
-- go_in's default of leaving it open for continued browsing.
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		vim.keymap.set("n", "<CR>", function()
			minifiles.go_in({ close_on_file = true })
		end, { buffer = buf_id, desc = "Go in entry (close on file)" })
		vim.keymap.set("n", "-", minifiles.go_out, { buffer = buf_id, desc = "Go out to parent" })
	end,
})

vim.keymap.set("n", "<leader>e", function()
	-- Anchor on the current buffer's file only if it's a real path on disk
	-- (e.g. not an unnamed buffer, terminal, or a plugin's scratch buffer
	-- such as vim.pack's install-progress buffer named after the plugin).
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" or not vim.uv.fs_stat(path) then
		path = vim.fn.getcwd()
	end
	minifiles.open(path, false)
end, { desc = "Open mini.files" })
