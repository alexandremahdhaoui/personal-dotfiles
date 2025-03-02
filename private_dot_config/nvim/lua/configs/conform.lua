local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofumpt", "golines", "goimports_reviser" },
		yaml = { "yamlfmt" },
		sh = { "shfmt" },
		python = { "black" },
		asm = { "asmfmt" },
		-- css = { "prettier" },
		-- html = { "prettier" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return options
