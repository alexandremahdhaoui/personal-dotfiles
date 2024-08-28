return {
	{
		"goolord/alpha-nvim",
		lazy = false,
		event = { "VimEnter" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
	{
		"aserowy/tmux.nvim",
		lazy = false,
		event = { "VimEnter" },
		config = function()
			local tmux = require("tmux")
			tmux.setup()
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		lazy = false,
		event = { "VimEnter" },
		config = function()
			local g = vim.g

			g.tpipeline_autoembed = 0
			g.tpipeline_restore = 1
			g.tpipeline_split = 1
			g.tpipeline_usepane = 1
			g.tpipeline_fillcentre = 0
			g.tpipeline_clearstl = 0
		end,
	},
}
