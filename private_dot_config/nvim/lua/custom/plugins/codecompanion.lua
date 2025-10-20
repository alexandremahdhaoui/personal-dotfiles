return {
	"olimorris/codecompanion.nvim",

	-- Options
	opts = {
		-- Adapters
		adapters = {
			acp = {
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {
						-- env = {
						--   -- Integrate with op: https://developer.1password.com/docs/cli/get-started/
						--   -- Create API key in Google AI Studio: https://aistudio.google.com/app/api-keys
						--   api_key = "cmd:op read op://personal/Gemini/credential --no-newline",
						-- },
					})
				end,
			},
		},

		-- Extensions
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
	},

	-- Config
	config = function(_, opts)
		require("codecompanion").setup(opts)

		-- Keymaps
		vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "[A]ction" })
		vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "[C]hat" })
		vim.keymap.set("n", "<leader>co", function()
			require("codecompanion").prompt("")
		end, { desc = "[O]pen chats", noremap = true, silent = true })

		vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<LocalLeader>a",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
	end,

	-- Prompt Library
	-- https://codecompanion.olimorris.dev/usage/introduction
	-- https://codecompanion.olimorris.dev/configuration/prompt-library
	-- https://codecompanion.olimorris.dev/extending/workflows#how-they-work
	-- prompt_library = require("private_dot_config.nvim.lua.custom.plugins.cc.prompts"),

	-- display
	display = {
		action_palette = {
			width = 95,
			height = 10,
			prompt = "Prompt ",         -- Prompt used for interactive LLM calls
			provider = "default",       -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
			opts = {
				show_default_actions = true, -- Show the default actions in the action palette?
				show_default_prompt_library = true, -- Show the default prompt library in the action palette?
				title = "CodeCompanion actions", -- The title of the action palette
			},
		},
	},

	dependencies = {
		"nvim-lua/plenary.nvim",

		-- MCP Hub
		-- https://ravitemer.github.io/mcphub.nvim/installation.html
		{
			"ravitemer/mcphub.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
			config = function()
				require("mcphub").setup()
			end,
		},

		-- render markdown in chat
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },

		-- nice diffs
		{
			"echasnovski/mini.diff",
			config = function()
				local diff = require("mini.diff")
				diff.setup({
					-- Disabled by default
					source = diff.gen_source.none(),
				})
			end,
		},
	},
}
