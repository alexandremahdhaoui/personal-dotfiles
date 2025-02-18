return {
	-- conform
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- This ensures that conform is loaded when opening a buffer or on new file.
		opts = require("configs.conform"), -- This will load nvim/lua/configs/conform.lua
	},
	{
		"zapling/mason-conform.nvim",
		event = "VeryLazy",
		dependencies = { "conform.nvim" },
		config = function()
			require("mason-conform").setup({ ignore_install = {} })
		end,
	},

	-- Copilot (Github)

	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = {
			sources = {
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "copilot", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "buffer", group_index = 2 },
				{ name = "nvim_lua", group_index = 2 },
				{ name = "path", group_index = 2 },
			},
		},
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.lspconfig") -- This will load nvim/lua/configs/lspconfig.lua
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lspconfig" },
	},

	-- nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.lint")
		end,
	},
	{
		"rshkarin/mason-nvim-lint",
		event = "VeryLazy",
		dependencies = { "nvim-lint" },
	},

	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function() -- This config is created by treesitter.lua in a particular manner
			require("configs.treesitter")
		end,
	},

	-- chezmoi
	{
		"xvzc/chezmoi.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("chezmoi").setup({
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
			})

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
			local telescope = require("nvchad.configs.telescope")

			require("telescope").load_extension("chezmoi")

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
