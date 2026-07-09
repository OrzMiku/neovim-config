local gh = require('modules.plugin-util').gh

return {
  {
    url = gh 'nvim-mini/mini.icons',
    name = 'mini.icons',
    lazy = false,
    config = function()
      local userconfig = require('config').get_config()
      local mini_icons = require 'mini.icons'
      mini_icons.setup {
        style = userconfig.features.have_nerd_font and 'glyph' or 'ascii',
      }
      mini_icons.mock_nvim_web_devicons()
    end,
  },
  {
    url = gh 'nvim-mini/mini.nvim',
    name = 'mini.nvim',
    event = 'VeryLazy',
    dependencies = {
      {
        url = gh 'rafamadriz/friendly-snippets',
        name = 'friendly-snippets',
      },
    },
    config = function()
      require('mini.ai').setup {
        n_lines = 500,
      }
      require('mini.surround').setup()
      require('mini.statusline').setup()
      require('mini.indentscope').setup {
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      }
      require('mini.pairs').setup {
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { 'string' },
        skip_unbalanced = true,
        markdown = true,
      }
      require('mini.move').setup()
      require('mini.comment').setup()

      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup {
        snippets = {
          gen_loader.from_lang(),
        },
      }
    end,
  },
  {
    url = gh 'folke/which-key.nvim',
    name = 'which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer keymaps',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show { keys = '<c-w>', loop = true }
        end,
        desc = 'Window keymaps',
      },
    },
    opts = {
      spec = {
        {
          mode = { 'n', 'x' },
          { '<leader>c', group = 'code' },
          { '<leader>d', group = 'debug' },
          { '<leader>f', group = 'find' },
          { '<leader>g', group = 'git' },
          { '<leader>gh', group = 'hunks' },
          { '[', group = 'previous' },
          { ']', group = 'next' },
          { 'g', group = 'goto' },
        },
      },
    },
  },
  {
    url = gh 'stevearc/oil.nvim',
    name = 'oil.nvim',
    lazy = false,
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
    opts = {},
  },
  {
    url = gh 'akinsho/bufferline.nvim',
    name = 'bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle buffer pin' },
      { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Delete non-pinned buffers' },
      { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Delete buffers right' },
      { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Delete buffers left' },
      { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Pick buffer' },
    },
    opts = function()
      return {
        highlights = require('catppuccin.special.bufferline').get_theme(),
      }
    end,
  },
  {
    url = gh 'Bekaboo/dropbar.nvim',
    name = 'dropbar.nvim',
    lazy = false,
  },
}
