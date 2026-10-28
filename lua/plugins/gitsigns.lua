return {
  'lewis6991/gitsigns.nvim',
  cmd = 'Gitsigns',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          desc = desc,
          silent = true,
        })
      end

      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, 'Next hunk')

      map('n', ']H', function()
        gitsigns.nav_hunk 'last'
      end, 'Last hunk')

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, 'Previous hunk')

      map('n', '[H', function()
        gitsigns.nav_hunk 'first'
      end, 'First hunk')

      map('n', '<leader>gs', gitsigns.stage_hunk, 'Stage hunk')

      map('x', '<leader>gs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Stage hunk')

      map('n', '<leader>gr', gitsigns.reset_hunk, 'Reset hunk')

      map('x', '<leader>gr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Reset hunk')

      map('n', '<leader>gS', gitsigns.stage_buffer, 'Stage buffer')
      map('n', '<leader>gR', gitsigns.reset_buffer, 'Reset buffer')
      map('n', '<leader>gp', gitsigns.preview_hunk_inline, 'Preview hunk')

      map('n', '<leader>gb', function()
        gitsigns.blame_line { full = true }
      end, 'Blame line')

      map('n', '<leader>gB', gitsigns.blame, 'Blame buffer')
      map('n', '<leader>gd', gitsigns.diffthis, 'Diff this')

      map('n', '<leader>gD', function()
        gitsigns.diffthis '~'
      end, 'Diff this ~')

      map('n', '<leader>gt', gitsigns.toggle_current_line_blame, 'Toggle line blame')
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
    end,
  },
}
