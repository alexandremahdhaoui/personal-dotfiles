-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

-- servers
local servers = {
	html = {},
	cssls = {},
	lua_ls = {},
	bashls = {},

	-- C
	clangd = {},

	-- Go
	golangci_lint_ls = {},
	gopls = {
		-- If MasonInstall fail, please run: go install -v golang.org/x/tools/gopls@latest
		settings = {
			gopls = {
				gofumpt = true,
				diagnosticsDelay = "300ms",
				symbolMatcher = "fuzzy",
				completeUnimported = true,
				staticcheck = true,
				matcher = "Fuzzy",
				usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
				env = {
					CGO_ENABLED = 0,
				},
				buildFlags = {
					"-tags=unit,integration,functional,amd64",
				},
				codelenses = {
					gc_details = true, -- Toggle the calculation of gc annotations
					generate = true, -- Runs go generate for a given directory
					regenerate_cgo = true, -- Regenerates cgo definitions
					tidy = true, -- Runs go mod tidy for a module
					upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
					vendor = true, -- Runs go mod vendor for a module
				},
				analyses = {
					fieldalignment = true, -- find structs that would use less memory if their fields were sorted
					nilness = true, -- check for redundant or impossible nil comparisons
					shadow = true, -- check for possible unintended shadowing of variables
					unusedparams = true, -- check for unused parameters of functions
					-- checks for unused writes, an instances of writes to struct fields and arrays that are never read
					unusedwrite = true,
				},
			},
		},
	},

	-- Helm
	helm_ls = {
		settings = {
			["helm-ls"] = {
				logLevel = "info",
				valuesFiles = {
					mainValuesFile = "values.yaml",
					lintOverlayValuesFile = "values.lint.yaml",
					additionalValuesFilesGlobPattern = "values*.yaml",
				},
				yamlls = {
					enabled = false,
					path = "yaml-language-server",
				},
			},
		},
	},

	-- Python
	pyright = {},

	-- Yaml
	yamlls = {
		yamlls = {
			enabled = true,
			diagnosticsLimit = 50,
			showDiagnosticsDirectly = false,
			path = "yaml-language-server",
			config = {
				schemas = {
					kubernetes = "templates/**",
				},
				completion = true,
				hover = true,
			},
		},
	},

	-- end
}

local nvlsp = require("nvchad.configs.lspconfig")

--------
-- lsps with default config
----
for lsp, opts in pairs(servers) do
	opts.on_attach = nvlsp.on_attach
	opts.on_init = nvlsp.on_init
	opts.capabilities = nvlsp.capabilities

	lspconfig[lsp].setup(opts)
end

-- util func
local function table_contains(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

--------
-- Ensure mason install non-ignored servers.
----
-- ignore list of servers
local ignore_install = { "golangci_lint_ls" }
-- overwrite install
local override_install = {}

local all_servers = {}

for s, _ in pairs(servers) do
	if override_install[s] ~= nil then
		table.insert(all_servers, override_install[s])
	elseif not table_contains(ignore_install, s) then
		table.insert(all_servers, s)
	end
end

require("mason-lspconfig").setup({
	ensure_installed = all_servers,
	automatic_installation = true,
})
