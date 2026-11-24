local map = vim.keymap.set

-- Gitsigns (on first buffer)
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.cmd.packadd 'gitsigns.nvim'
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = desc,
            silent = true,
          })
        end

        bmap('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Next hunk')

        bmap('n', ']H', function()
          gitsigns.nav_hunk 'last'
        end, 'Last hunk')

        bmap('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Previous hunk')

        bmap('n', '[H', function()
          gitsigns.nav_hunk 'first'
        end, 'First hunk')

        bmap('n', '<leader>gs', gitsigns.stage_hunk, 'Stage hunk')

        bmap('x', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Stage hunk')

        bmap('n', '<leader>gr', gitsigns.reset_hunk, 'Reset hunk')

        bmap('x', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Reset hunk')

        bmap('n', '<leader>gS', gitsigns.stage_buffer, 'Stage buffer')
        bmap('n', '<leader>gR', gitsigns.reset_buffer, 'Reset buffer')
        bmap('n', '<leader>gp', gitsigns.preview_hunk_inline, 'Preview hunk')

        bmap('n', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, 'Blame line')

        bmap('n', '<leader>gB', gitsigns.blame, 'Blame buffer')
        bmap('n', '<leader>gd', gitsigns.diffthis, 'Diff this')

        bmap('n', '<leader>gD', function()
          gitsigns.diffthis '~'
        end, 'Diff this ~')

        bmap('n', '<leader>gt', gitsigns.toggle_current_line_blame, 'Toggle line blame')
        bmap({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
      end,
    }
  end,
})

-- Neogit & CodeDiff (deferred after first draw)
vim.schedule(function()
  vim.cmd.packadd 'plenary.nvim'
  vim.cmd.packadd 'neogit'
  require('neogit').setup { integrations = { fzf_lua = true } }
  map('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Show Neogit UI' })

  vim.cmd.packadd 'codediff.nvim'
end)
