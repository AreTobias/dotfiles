-- markdown-preview needs its prebuilt node app downloaded after install/update.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local spec, kind = ev.data.spec, ev.data.kind
		if spec.name == "markdown-preview.nvim" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("markdown-preview.nvim")
			end
			vim.fn["mkdp#util#install"]()
		end
	end,
})

vim.pack.add({
	"https://github.com/iamcco/markdown-preview.nvim",
})

-- Commands: :MarkdownPreview, :MarkdownPreviewStop, :MarkdownPreviewToggle
