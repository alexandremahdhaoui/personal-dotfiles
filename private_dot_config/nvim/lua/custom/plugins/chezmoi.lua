return {
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

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(_)
        vim.keymap.set(
          "n",
          "<leader>z",
          require("telescope").extensions.chezmoi.find_files,
          { desc = "[C]hezmoi" }
        )
      end,
    })
  end,
}
