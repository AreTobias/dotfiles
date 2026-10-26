vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

local sessions = require("mini.sessions")

-- autoread/autowrite left off on purpose: autoread would fight with
-- mini.starter's dashboard on a plain `nvim` with no args, loading a
-- session over it instead of showing the starter screen. Sessions are
-- opt-in via the keymaps below instead.
sessions.setup({
	autoread = false,
	autowrite = false,
})

vim.keymap.set("n", "<leader>ss", function()
	-- writes a local "Session.vim" in the current working directory
	sessions.write(sessions.config.file)
end, { desc = "Save session for cwd" })

vim.keymap.set("n", "<leader>sl", function()
	sessions.select("read")
end, { desc = "Load session" })

vim.keymap.set("n", "<leader>sd", function()
	sessions.select("delete")
end, { desc = "Delete session" })
