return {
	"romgrk/barbar.nvim",
	config = function()
		require('lazy').setup {
		  {'romgrk/barbar.nvim',
		    dependencies = {
		      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
		      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		    },
		    init = function() vim.g.barbar_auto_setup = false end,
		    opts = {
		      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		      -- animation = true,
		      -- insert_at_start = true,
		      --
		      -- …etc.
		      vim.keymap.set('n', '<TAB>', "<Cmd>BufferNext<CR>"),
		      vim.keymap.set('n', '<S-TAB>', "<Cmd>BufferPrevious<CR>"),
		      vim.keymap.set('n', '<leader>x', "<Cmd>BufferClose<CR>"),
		      -- vim.keymap.set('n', 'C-h', "<Cmd>BufferMovePrevious<CR>"),
		      -- vim.keymap.set('n', 'C-l', "<Cmd>BufferMoveNext<CR>"),


		    },
		    version = '^1.0.0', -- optional: only update when a new 1.x version is released
		  },
		}
	end,

}
