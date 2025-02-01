return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		recommended = true,
		desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

		dependencies = {
			"rcarriga/nvim-dap-ui",
			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},

		-- stylua: ignore
		keys = {
		  { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
		  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
		  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		  { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
		  { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
		  { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
		  { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
		  { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		  { "<leader>dj", function() require("dap").down() end, desc = "Down" },
		  { "<leader>dk", function() require("dap").up() end, desc = "Up" },
		  { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
		  { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
		  { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
		  { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
		  { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		  { "<leader>ds", function() require("dap").session() end, desc = "Session" },
		  { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		  { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		},

		config = function()
			local dap = require("dap")
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

			-- Add Delve adapter configuration
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
					-- uncomment the following line if you are using Windows
					-- detached = false,
				},
			}

			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
			dap.adapters.gdb = {
				id = "gdb",
				type = "executable",
				command = "gdb",
				args = { "--quiet", "--interpreter=dap" },
			}

			dap.configurations.c = {
				{
					name = "Run executable (GDB)",
					type = "gdb",
					request = "launch",
					-- This requires special handling of 'run_last', see
					-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/",
							completion = "file",
						})

						return (path and path ~= "") and path or dap.ABORT
					end,
				},

				{
					name = "Run executable with arguments (GDB)",
					type = "gdb",
					request = "launch",
					-- This requires special handling of 'run_last', see
					-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/",
							completion = "file",
						})

						return (path and path ~= "") and path or dap.ABORT
					end,
					args = function()
						local args_str = vim.fn.input({
							prompt = "Arguments: ",
						})
						return vim.split(args_str, " +")
					end,
				},

				{
					name = "Attach to process (GDB)",
					type = "gdb",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}
		end,
	},
}
