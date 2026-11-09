vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

-- Insert a blank line between consecutive YAML sequence items ("- ...") at the
-- same indent. Skips block scalar contents (| and >) and keeps comments that
-- sit directly above an item attached to it.
local function yaml_item_spacing(_, _, lines, callback)
	local out = {}
	local scalar_indent = nil
	for _, line in ipairs(lines) do
		local indent = #line:match("^%s*")
		local blank = line:match("^%s*$") ~= nil

		if scalar_indent and not blank and indent <= scalar_indent then
			scalar_indent = nil
		end

		if not scalar_indent then
			local dash = line:match("^%s*%- ") or line:match("^%s*%-$")
			if dash then
				-- Walk back past comments attached to this item
				local insert_at = #out + 1
				while insert_at > 1 and out[insert_at - 1]:match("^%s*#") do
					insert_at = insert_at - 1
				end
				local prev = out[insert_at - 1]
				if prev and not prev:match("^%s*$") then
					-- Find the nearest earlier line at this indent or less
					for i = insert_at - 1, 1, -1 do
						local l = out[i]
						if not l:match("^%s*$") and not l:match("^%s*#") then
							local li = #l:match("^%s*")
							if li < indent then
								break
							elseif li == indent then
								if l:match("^%s*%-") then
									table.insert(out, insert_at, "")
								end
								break
							end
						end
					end
				end
			end
			if line:match("[:%-]%s+[|>][%d+-]*%s*$") and not line:match("^%s*#") then
				-- Content of the scalar is indented past the key's column
				scalar_indent = #line:match("^[%s%-]*")
			end
		end

		table.insert(out, line)
	end
	callback(nil, out)
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- ruff replaces isort + black: sort imports, then format
		python = { "ruff_organize_imports", "ruff_format" },
		yaml = { "yamlfix", "yaml_item_spacing" },
	},
	formatters = {
		yaml_item_spacing = {
			format = yaml_item_spacing,
		},
		yamlfix = {
			env = {
				YAMLFIX_SEQUENCE_STYLE = "block_style",
				YAMLFIX_WHITELINES = "1",
			},
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
