local plugins = {
  -- chezmoi
  {
    'xvzc/chezmoi.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("chezmoi").setup {
        edit = {
          watch = false,
          force = false,
        },
        notification = {
          on_open = true,
          on_apply = true,
          on_watch = false,
        },
        telescope = {
          select = { "<CR>" },
        },
      }

      -- auto save
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      	pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
      	callback = function()
          vim.schedule(require("chezmoi.commands.__edit").watch)
      	end,
      })
    end,
  },

  -- Telescope (overwrite default config)
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local telescope = require "nvchad.configs.telescope"

      require('telescope').load_extension('chezmoi')

      return telescope
    end,
  },

  -- Tmux
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
       { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
       { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
       { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
       { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
}

return plugins
