vim.pack.add({
	"https://github.com/muniftanjim/nui.nvim",
	"https://github.com/folke/noice.nvim",
})

require("noice").setup({
	lsp = {
		-- render LSP hover/signature markdown with Treesitter
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = true, -- classic bottom cmdline for search
		command_palette = true, -- cmdline and popupmenu together
		long_message_to_split = true, -- long messages go to a split
		inc_rename = false,
		lsp_doc_border = false,
	},
})
