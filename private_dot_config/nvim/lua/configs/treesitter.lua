local options = {
	ensure_installed = {
		"bash",
		"json",
		"go",
		"lua",
		"luadoc",
		"markdown",
		"printf",
		"python",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
