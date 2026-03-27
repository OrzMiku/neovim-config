---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        ':Neotree toggle<cr>',
        desc = 'Toggle NeoTree',
      },
    },
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        width = 36,
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>fs', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fp', '<cmd>Telescope git_files<cr>', desc = 'Find git files' },
      { '<leader>fz', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Find recent files' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Find keymaps' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help documentation' },
      { '<leader>f?', '<cmd>Telescope help_tags<cr>', desc = 'Find help documentation' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      current_line_blame = true,
    },
  },
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {},
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },
}
