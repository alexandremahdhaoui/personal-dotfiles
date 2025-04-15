require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- chezmoi
map("n", "<leader>cz", require("telescope").extensions.chezmoi.find_files, { desc = "chezmoi" })

-- copilot
map("i", "<C-l>", function()
    require("copilot.suggestion").accept()
end, { desc = "Copilot Accept", replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true })

-- tmux
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
