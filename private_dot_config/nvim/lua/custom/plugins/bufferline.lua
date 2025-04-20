return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = {
      { "<Tab>",   "<cmd>BufferLineCycleNext<cr>",   desc = "Select the next buffer tab" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>",   desc = "Select the previous buffer tab" },
      { "<bco>",   "<cmd>BufferLineCloseOthers<cr>", desc = "Close all other buffers" },
      { "<bcl>",   "<cmd>BufferLineCloseLeft<cr>",   desc = "Close left buffers" },
      { "<bcr>",   "<cmd>BufferLineCloseRigth<cr>",  desc = "Close right buffers" },
    },
  },
}
