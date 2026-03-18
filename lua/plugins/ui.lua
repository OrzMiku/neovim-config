return {
  {
    'nvim-tree/nvim-web-devicons',
    enable = function()
      return vim.g.have_nerd_font
    end,
    lazy = true,
    opts = {},
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.statusline').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  {
    'sphamba/smear-cursor.nvim',
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
}
