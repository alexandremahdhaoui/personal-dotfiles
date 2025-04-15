return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = {
      { "<Tab>",   "<cmd>BufferLineCycleNext<cr>", desc = "Select the next buffer tab" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Select the previous buffer tab" },
    },
  },
}
