local options = {
	ensure_installed = {
		"asm",
		"bash",
		"c",
		"json",
		"go",
		"lua",
		"luadoc",
		"markdown",
		"printf",
		"proto",
		"python",
		"rust",
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
