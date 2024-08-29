require("nvchad.options")

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.mouse = ""
o.cmdheight = 0 -- makes lualine on top of tmux status line.

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
