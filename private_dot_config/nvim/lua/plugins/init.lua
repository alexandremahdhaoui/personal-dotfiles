return {
	-- conform
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- This ensures that conform is loaded when opening a buffer or on new file.
		opts = require("configs.conform"), -- This will load nvim/lua/configs/conform.lua
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.lspconfig") -- This will load nvim/lua/configs/lspconfig.lua
		end,
	},

  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile"},
    config = function ()
      require("configs.lint")
    end,
  },

	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function() -- This config is created by treesitter.lua in a particular manner
			require("configs.treesitter")
		end,
	},
}
