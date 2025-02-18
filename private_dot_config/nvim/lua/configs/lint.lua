local lint = require("lint")

-- List of linters to ignore during install
local ignore_install = {}

lint.linters_by_ft = {
	lua = { "luacheck" },
	python = { "mypy", "ruff" },
	sh = { "shellcheck" },
	-- proto = { "protols" }, -- Protocol Buffers
	-- go = { "golangcilint" },
}

lint.linters.luacheck.args = {
	"--globals",
	"love",
	"vim",
	"--formatter",
	"plain",
	"--codes",
	"--ranges",
	"-",
}

lint.linters.shellcheck.args = { "--severity", "warning" }

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

-- Mason auto-install
local function table_contains(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

local all_linters = {}
for _, v in pairs(lint.linters_by_ft) do
	for _, l in ipairs(v) do
		if l == "golangcilint" then
			table.insert(all_linters, "golangci-lint")
		elseif not table_contains(ignore_install, l) then
			table.insert(all_linters, l)
		end
	end
end

require("mason-nvim-lint").setup({
	ensure_installed = all_linters,
	automatic_instllation = false,
})
