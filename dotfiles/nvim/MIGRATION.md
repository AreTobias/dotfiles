# 2026-09-14 plugin cleanup + conservative mini.nvim migration

This documents every change made, why, and exactly how to revert each one
independently. Nothing was deleted — everything superseded was moved to
`lua/plugins/disabled/` instead, so reverting is always "move the file back +
edit two lines in init.lua".

## 1. Loader made resilient (`lua/plugins/init.lua`)

Previously every plugin file was loaded with a bare `require("plugins.x")`.
Because `obsidian-nvim.lua` throws a hard error at startup (see #6 below),
**every plugin listed after it in the file silently failed to load** —
render-markdown, markdown-preview, tabbout, tiny-code-action, blink-cmp,
blink-rg and luasnip were all dead despite being "required". This is very
likely why several plugins felt "not included" in the first place.

`init.lua` now defines a small `load(name)` helper that wraps `require` in
`pcall` and reports failures via `vim.notify` instead of aborting the rest
of the chain.

**To revert:** replace every `load("plugins.x")` call back with
`require("plugins.x")` and delete the `load` function at the top of the
file.

## 2. Plugins that existed but were never loaded — now added

These files existed on disk with real config in them but had no
`require`/`load` line in `lua/plugins/init.lua`, so they never ran:

| File | Notes |
|---|---|
| `treesitter.lua` | Was completely inactive. Also had a syntax error, `andvim.api.nvim_create_autocmd(...)` (missing space after `and`) — fixed to `vim.api.nvim_create_autocmd(...)`. |
| `tabbout.lua` | Tab-to-exit-bracket-pairs plugin, unrelated to autopairs. |
| `tiny-ca.lua` | tiny-code-action.nvim, `<leader>ca` code actions. |
| `luasnip.lua` | Kept since completion (blink.cmp) was left untouched. |

**To revert:** remove the corresponding `load("plugins.x")` line from
`init.lua`. For treesitter, the syntax fix is a real bug fix independent of
this migration — only revert it if you want treesitter broken again.

## 3. Dead/duplicate files retired (not part of the mini.nvim swap)

| File | Why removed from load path |
|---|---|
| `nvim-lspconfig.lua` | Pure duplicate — `mason.lua` already does `vim.pack.add` for `neovim/nvim-lspconfig`, and `schemastore.lua` already calls `require("lspconfig")`. This file added nothing. |
| `mason-lspconfig.lua` | Had a syntax error (`)}` instead of `})`) so it could never have run anyway, and duplicated the `mason-lspconfig.nvim` setup that `mason.lua` already does. |

Moved to `lua/plugins/disabled/`, not required anywhere.

**To revert:** move the file back to `lua/plugins/` and add
`load("plugins.<name>")` back to `init.lua`. Note `mason-lspconfig.lua`
still has its original syntax error — fix the `)}` on line 3 to `})` first.

## 4. Also fixed: `blink-rg.lua`

The git URL had a trailing slash (`.../blink-ripgrep.nvim/`), which made
`vim.pack.add` fail with `spec.name: expected non-empty string`. Removed the
trailing slash.

**To revert:** add the trailing slash back (not recommended, it's just a
bug).

## 5. Conservative mini.nvim swap

Per your choice, only the "safe"/near-equivalent swaps were made. Telescope
and blink.cmp/luasnip were deliberately left alone (mini.pick and
mini.completion are meaningfully less capable, per our earlier discussion —
ask me if you later want to revisit that).

Each swap is its own new file, and the old plugin's file was moved to
`lua/plugins/disabled/` rather than deleted, so you can A/B test and revert
any single one independently.

| Old (now in `disabled/`) | New file | mini module | Notes / feature gaps |
|---|---|---|---|
| `lualine.lua` | `mini-statusline.lua` | `mini.statusline` | Close to 1:1. |
| `dashboard.lua` + `alpha-dashboard.lua` | `mini-starter.lua` | `mini.starter` | Both old dashboards replaced by one. Default mini.starter look is plainer; customize `require("mini.starter").setup({...})` if you want the hyper/startify look back. |
| `oil.lua` + `oil-gitstatus.lua` + `neo-tree.lua` | `mini-files.lua` | `mini.files` | `<leader>e` keymap preserved (opens at current file). `neo-tree.lua` was unused/broken anyway (written in lazy.nvim `return {}` format, incompatible with `vim.pack`). |
| `treesj.lua` | `mini-splitjoin.lua` | `mini.splitjoin` | `<leader>m` toggle keymap preserved. |
| `whichkey.lua` | `mini-clue.lua` | `mini.clue` | Behavior differs: which-key's `<leader>?` was a manual popup; mini.clue auto-shows a popup ~300ms after you press a trigger key (`<leader>`, `g`, `z`, marks, registers, windows, etc.) and there's no direct manual-trigger equivalent, so the `<leader>?` keymap was dropped. |
| `gitsigns.lua` | `mini-diff.lua` | `mini.diff` | Diff signs (add/change/delete) are equivalent. **Feature loss:** gitsigns' `current_line_blame` has no mini.diff equivalent — if you use that, keep gitsigns instead. |
| — | (existing `mini.lua`, now actually loaded) | `mini.ai`, `mini.pairs`, `mini.surround`, `mini.icons`, `mini.jump` | This file already existed with correct config but was never `require`d — now it is. `mini.pairs` replaces `autoclose.nvim` + `nvim-autopairs` (both moved to `disabled/`), `mini.icons` replaces `nvim-web-devicons` (moved to `disabled/`). |

**To revert any one swap:**
1. Move the old file from `lua/plugins/disabled/` back to `lua/plugins/`.
2. In `lua/plugins/init.lua`, remove the corresponding `load("plugins.mini-x")` line and add `load("plugins.<old-name>")` back in its place.
3. If it's one of the mini core modules (pairs/icons), also comment out that specific `require("mini.x").setup()` line inside `lua/plugins/mini.lua` so you don't get both systems fighting over the same behavior (e.g. two autopairs plugins).

## 6. `obsidian-nvim.lua` — fixed (pre-existing, unrelated to the mini.nvim work)

Two bugs, both now fixed:

- The configured workspaces pointed at `~/vaults/Work` and
  `~/vaults/Development`, which don't exist. Replaced with your real vault:
  a single workspace named "Are Tobias Vault" at
  `~/Documents/Obsidian/Are Tobias Vault`. Also fixed a `notes_dubdir` typo
  (should be `notes_subdir`, the option obsidian.nvim actually reads).
- `completion.nvim_cmp = true` was leftover from before this config switched
  to blink.cmp — `cmp` isn't installed, so obsidian.nvim crashed trying to
  register an nvim-cmp source. This obsidian.nvim version has no blink.cmp
  integration at all, so it's set to `nvim_cmp = false`; obsidian's own
  completions (wiki-links, tags) just aren't wired into blink.cmp.

**To revert:** restore the two `~/vaults/...` workspace entries and
`nvim_cmp = true` in `lua/plugins/obsidian-nvim.lua` (not recommended, both
were broken).

Thanks to the loader fix in #1, none of this could break any other plugin
regardless.

## 8. Obsidian completion wired into blink.cmp

This installed obsidian.nvim (`epwalsh/obsidian.nvim`, the old architecture —
not the newer `obsidian-nvim/obsidian.nvim` fork, which gets completion via
an in-process LSP instead) only ships **nvim-cmp** sources
(`cmp_obsidian`, `cmp_obsidian_new`, `cmp_obsidian_tags`). blink.cmp can't
consume those directly, so:

- `plugins/obsidian-nvim.lua` now also `vim.pack.add`s `hrsh7th/nvim-cmp`
  (only for its `cmp` module/source registry — `cmp.setup()` is never
  called, so it never renders its own completion UI) and
  `completion.nvim_cmp = true` makes obsidian call
  `cmp.register_source(...)` for those three sources at startup.
- `plugins/blink-cmp.lua` now also `vim.pack.add`s `saghen/blink.compat`
  (a shim that lets blink.cmp read nvim-cmp sources) and adds
  `obsidian`/`obsidian_new`/`obsidian_tags` as `blink.compat.source`
  providers, enabled only for `markdown` filetype in `sources.per_filetype`.

Verified: `require('cmp').core.sources` shows all three obsidian sources
registered, and blink.cmp's resolved config shows them in
`sources.per_filetype.markdown`. Note the upstream blink.compat docs warn
triggering behavior can differ slightly from nvim-cmp's, and blink.cmp API
changes have occasionally broken this compat shim — pin versions if you hit
issues.

**To revert:** in `obsidian-nvim.lua`, drop the `nvim-cmp` `vim.pack.add`
block and set `nvim_cmp = false`. In `blink-cmp.lua`, drop the
`blink.compat` `vim.pack.add` block and revert `sources` back to:

```lua
sources = {
	default = { "lsp", "path", "snippets", "buffer" },
	per_filetype = {
		markdown = { "lsp", "path", "buffer" },
	},
},
```

## 7. Left disabled on purpose (unchanged from before)

- `barbar.lua` — was already commented out in `init.lua`. mini.nvim does have
  a bufferline equivalent (`mini.tabline`) but you hadn't confirmed you
  wanted a bufferline enabled, so it's untouched. Say the word if you want
  it wired up as `mini-tabline.lua`.
- `telescope-frecency.lua` — was already commented out; left as-is since the
  full Telescope stack was kept.
