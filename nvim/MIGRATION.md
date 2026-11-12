# Config notes

Neovim 0.12, plugins managed with the built-in `vim.pack`. This file records
the decisions that are still in effect; superseded history has been removed.

Backup of the config as of 2026-11-12 (taken after that day's edits, and still
containing `lua/plugins/disabled/`): `~/.config/nvim-backup-2026-11-12.tar.gz`.

## Layout

- `init.lua` sets the leader, then loads `lua/config/` and `lua/plugins/`.
- `lua/plugins/init.lua` loads one file per plugin through a `pcall` wrapper,
  so one failing plugin reports an error instead of stopping the rest.
- `lua/config/lsp.lua` is the only place that decides which LSP servers run
  (`vim.lsp.enable`). Mason only installs them (`automatic_enable = false`).
- `lsp/*.lua` holds per-server overrides merged over nvim-lspconfig's defaults.

## mini.nvim replacements (2026-09-14)

| Replaced | By | Note |
|---|---|---|
| lualine | `mini.statusline` | |
| dashboard-nvim, alpha-nvim | `mini.starter` | customised header, footer and actions |
| oil, oil-git-status, neo-tree | `mini.files` | `<leader>e`; `<CR>` and `-` added |
| treesj | `mini.splitjoin` | `<leader>m` |
| which-key | `mini.clue` | popup after 300 ms, no manual trigger |
| gitsigns | `mini.diff` | no current-line blame |
| autoclose, nvim-autopairs | `mini.pairs` | |
| nvim-web-devicons | `mini.icons` | mocks devicons for barbar |

Telescope and blink.cmp were kept on purpose (mini.pick and mini.completion are
less capable). barbar was kept over `mini.tabline`.

## Other standing decisions

- TypeScript uses `ts_ls`. Servers not installed yet are listed commented in
  `config/lsp.lua` with their `:MasonInstall` names. Extra servers can be
  enabled per machine with `vim.g.lsp_on_demands`.
- Python formatting is `ruff_organize_imports` + `ruff_format`.
- obsidian.nvim is the maintained `obsidian-nvim` fork. Its completion comes
  through its in-process LSP, so blink.cmp needs no compat shim.
- Snippets are served by blink.cmp's built-in engine with friendly-snippets.
  LuaSnip was removed from the load list on 2026-11-12 because blink was never
  configured to use it.
- mini.sessions has `autoread`/`autowrite` off so it cannot load a session over
  the starter screen.

## 2026-11-12 changes

| Change | File |
|---|---|
| Harpoon slots moved from `<C-h>/<C-t>/<C-n>/<C-s>` to `<leader>1`–`4`. `<C-h>` was overwriting tmux-navigator's "focus left". | `plugins/harpoon.lua` |
| Buffer cycling moved from `<Tab>/<S-Tab>` to `L`/`H`, so `<C-i>` (same key as `<Tab>` in most terminals) is jumplist-forward again. | `plugins/barbar.lua` |
| `desc` added to harpoon, barbar and code-action maps; group labels for `<leader>c/f/g/s/t`. | `plugins/mini-clue.lua` and others |
| `lua_ls` loads the Neovim runtime and luv types instead of only whitelisting the `vim` global. | `lsp/lua_ls.lua` |
| Format on save: timeout 500 → 2000 ms, `<leader>tf` toggles it (`vim.g.disable_autoformat`). | `plugins/conform.lua` |
| `jinja_lsp` added to Mason's `ensure_installed`. | `plugins/mason.lua` |
| LuaSnip and telescope-frecency no longer loaded; commented catppuccin block removed. | `plugins/init.lua`, `plugins/colorscheme.lua` |
