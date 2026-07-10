local gh = require('modules.plugin-util').gh

return {
  {
    url = gh 'lewis6991/gitsigns.nvim',
    name = 'gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end

        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Gitsigns next hunk')
        map('n', ']H', function()
          gitsigns.nav_hunk 'last'
        end, 'Gitsigns last hunk')
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Gitsigns previous hunk')
        map('n', '[H', function()
          gitsigns.nav_hunk 'first'
        end, 'Gitsigns first hunk')

        map('n', '<leader>ghs', gitsigns.stage_hunk, 'Gitsigns stage hunk')
        map('x', '<leader>ghs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Gitsigns stage hunk')
        map('n', '<leader>ghr', gitsigns.reset_hunk, 'Gitsigns reset hunk')
        map('x', '<leader>ghr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Gitsigns reset hunk')
        map('n', '<leader>ghS', gitsigns.stage_buffer, 'Gitsigns stage buffer')
        map('n', '<leader>ghu', gitsigns.undo_stage_hunk, 'Gitsigns undo stage hunk')
        map('n', '<leader>ghR', gitsigns.reset_buffer, 'Gitsigns reset buffer')
        map('n', '<leader>ghp', gitsigns.preview_hunk_inline, 'Gitsigns preview hunk inline')
        map('n', '<leader>ghb', function()
          gitsigns.blame_line { full = true }
        end, 'Gitsigns blame line')
        map('n', '<leader>ghB', gitsigns.blame, 'Gitsigns blame buffer')
        map('n', '<leader>ghd', gitsigns.diffthis, 'Gitsigns diff this')
        map('n', '<leader>ghD', function()
          gitsigns.diffthis '~'
        end, 'Gitsigns diff this ~')
        map('n', '<leader>ght', gitsigns.toggle_current_line_blame, 'Gitsigns toggle line blame')
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Gitsigns select hunk')
      end,
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
