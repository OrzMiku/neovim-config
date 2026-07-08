local gh = require('modules.plugin-util').gh

return {
  {
    url = gh 'lewis6991/gitsigns.nvim',
    name = 'gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        ']h',
        function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            require('gitsigns').nav_hunk 'next'
          end
        end,
        desc = 'Gitsigns next hunk',
      },
      {
        ']H',
        function()
          require('gitsigns').nav_hunk 'last'
        end,
        desc = 'Gitsigns last hunk',
      },
      {
        '[h',
        function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            require('gitsigns').nav_hunk 'prev'
          end
        end,
        desc = 'Gitsigns previous hunk',
      },
      {
        '[H',
        function()
          require('gitsigns').nav_hunk 'first'
        end,
        desc = 'Gitsigns first hunk',
      },
      {
        'gp',
        function()
          require('gitsigns').preview_hunk()
        end,
        desc = 'Gitsigns preview hunk',
      },
      {
        'gP',
        function()
          require('gitsigns').preview_hunk_inline()
        end,
        desc = 'Gitsigns preview hunk inline',
      },
      { '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', mode = { 'n', 'x' }, desc = 'Gitsigns stage hunk' },
      { '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', mode = { 'n', 'x' }, desc = 'Gitsigns reset hunk' },
      {
        '<leader>ghS',
        function()
          require('gitsigns').stage_buffer()
        end,
        desc = 'Gitsigns stage buffer',
      },
      {
        '<leader>ghu',
        function()
          require('gitsigns').undo_stage_hunk()
        end,
        desc = 'Gitsigns undo stage hunk',
      },
      {
        '<leader>ghR',
        function()
          require('gitsigns').reset_buffer()
        end,
        desc = 'Gitsigns reset buffer',
      },
      {
        '<leader>ghp',
        function()
          require('gitsigns').preview_hunk_inline()
        end,
        desc = 'Gitsigns preview hunk inline',
      },
      {
        '<leader>ghb',
        function()
          require('gitsigns').blame_line { full = true }
        end,
        desc = 'Gitsigns blame line',
      },
      {
        '<leader>ghB',
        function()
          require('gitsigns').blame()
        end,
        desc = 'Gitsigns blame buffer',
      },
      {
        '<leader>ghd',
        function()
          require('gitsigns').diffthis()
        end,
        desc = 'Gitsigns diff this',
      },
      {
        '<leader>ghD',
        function()
          require('gitsigns').diffthis '~'
        end,
        desc = 'Gitsigns diff this ~',
      },
      { 'ih', '<cmd>Gitsigns select_hunk<cr>', mode = { 'o', 'x' }, desc = 'Gitsigns select hunk' },
    },
    opts = {
      current_line_blame = true,
    },
  },
  {
    url = gh 'NeogitOrg/neogit',
    name = 'neogit',
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
    dependencies = {
      {
        url = gh 'nvim-lua/plenary.nvim',
        name = 'plenary.nvim',
      },
      {
        url = gh 'dlyongemallo/diffview-plus.nvim',
        name = 'diffview-plus.nvim',
      },
    },
  },
}
