return {
	-- {
	-- 	"startup-nvim/startup.nvim",
	-- 	requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	-- 	lazy = false,
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		require("startup").setup()
	-- 	end,
	-- },
	{
		"goolord/alpha-nvim",
		lazy = false,
		event = { "VimEnter" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
}
