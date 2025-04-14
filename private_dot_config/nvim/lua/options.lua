require("nvchad.options")

vim.cmd([[hi Normal guifg=white guibg=black]])
vim.cmd([[hi Visual guifg=black guibg=white]])

local o = vim.o

o.cursorlineopt = "both" -- to enable cursorline!
o.mouse = ""
o.cmdheight = 0 -- makes lualine on top of tmux status line.

o.tabstop = 4 -- a tab is 4 spaces
o.shiftwidth = 4 -- number of spaces inserted when indenting

--- resizing windows
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

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
