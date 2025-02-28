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
			tmux.setup({
				copy_sync = {
					enable = false, -- this allow copypasting from/to system
				},
			})
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		lazy = false,
		event = { "VimEnter" },
		init = function()
			vim.g.tpipeline_autoembed = 0
			vim.g.tpipeline_statusline = ""
		end,
		config = function()
			vim.cmd.hi({ "link", "StatusLine", "WinSeparator" })
			vim.g.tpipeline_autoembed = 0
			vim.o.laststatus = 0
			vim.o.fillchars = "stl:-,stlnc:-"
		end,
		cond = function()
			return vim.env.TMUX ~= nil
		end,
	},
}
