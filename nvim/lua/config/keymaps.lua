local map = vim.keymap.set

-- Not mapped here on purpose:
--   <C-h/j/k/l>  tmux-navigator   H/L  barbar   n/N  nvim-hlslens
--   <leader>1-4  harpoon slots
-- Built in since 0.11: grn rename, gra code action, grr references,
-- gri implementation, gO symbols, K hover, ]d/[d next/prev diagnostic.

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Keep selection after indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move by visual line when wrapped (counts like 5j still move real lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Keep cursor centered on half-page jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Paste over a selection without overwriting the yank register
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Leave terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Telescope LSP / diagnostics pickers
map("n", "<leader>fr", "<Cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
map("n", "<leader>fs", "<Cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>fd", "<Cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics" })
