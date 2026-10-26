vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/theprimeagen/harpoon", version = "harpoon2" },
})
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

vim.keymap.set("n", "<leader>r", function()
	harpoon:list():remove()
end, { desc = "Removes a file from Harpoon buffer" })

-- Telescope integration: show the Harpoon list in a Telescope picker
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_list)
	-- Removing a mark leaves an empty slot, so walk by index instead of ipairs
	-- (which stops at the first gap) and remember each entry's slot.
	local function make_finder()
		local results = {}
		for i = 1, harpoon_list:length() do
			local item = harpoon_list.items[i]
			if item then
				table.insert(results, { index = i, value = item.value })
			end
		end
		return require("telescope.finders").new_table({
			results = results,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.value,
					ordinal = entry.value,
					filename = entry.value,
				}
			end,
		})
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon (dd / <M-d> to remove)",
			finder = make_finder(),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local action_state = require("telescope.actions.state")
				local function remove_selected()
					local selection = action_state.get_selected_entry()
					if not selection then
						return
					end
					harpoon_list:remove_at(selection.value.index)
					harpoon:sync()
					action_state.get_current_picker(prompt_bufnr):refresh(make_finder(), { reset_prompt = false })
				end
				map("n", "dd", remove_selected)
				map("i", "<M-d>", remove_selected)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>fm", function()
	toggle_telescope(harpoon:list())
end, { desc = "Telescope harpoon marks" })
