return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
    keys = {
      { "<Tab>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Select the next buffer tab" },
      { "<S-Tab>",    "<cmd>BufferLineCyclePrev<cr>",   desc = "Select the previous buffer tab" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "[B]uffers: close all [o]thers" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>",   desc = "[B]uffers: close [l]eft" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>",  desc = "[B]uffers: close [r]ight" },
      { "<leader>bp", "<cmd>BufferLinePickClose<cr>",   desc = "[B]uffers: close [p]icked" },
    },
  },
}
