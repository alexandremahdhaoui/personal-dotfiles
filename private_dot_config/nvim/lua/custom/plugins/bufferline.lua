return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = {
      { "<Tab>",       "<cmd>BufferLineCycleNext<cr>",   desc = "Select the next buffer tab" },
      { "<S-Tab>",     "<cmd>BufferLineCyclePrev<cr>",   desc = "Select the previous buffer tab" },
      { "<leader>bco", "<cmd>BufferLineCloseOthers<cr>", desc = "[B]uffers: [c]lose all [o]thers" },
      { "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>",   desc = "[B]uffers: [c]lose [l]eft" },
      { "<leader>bcr", "<cmd>BufferLineCloseRight<cr>",  desc = "[B]uffers: [c]lose [r]ight" },
    },
  },
}
