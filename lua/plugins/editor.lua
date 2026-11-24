local map = vim.keymap.set

-- Oil (immediate, handles directory arguments)
require('oil').setup {}
map('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

-- Deferred after first draw
vim.schedule(function()
  vim.cmd.packadd 'mini.move'
  require('mini.move').setup {}

  vim.cmd.packadd 'conform.nvim'
  require('conform').setup(vim.deepcopy(UserConfig.formatter))
  map({ 'n', 'x' }, '<leader>cf', function()
    require('conform').format {}
  end, { desc = 'Code format' })

  vim.cmd.packadd 'fzf-lua'
  local fzf = require 'fzf-lua'
  fzf.setup {
    fzf_colors = true,
    ui_select = {},
  }
  map('n', '<leader>ff', fzf.files, { desc = 'Find files' })
  map('n', '<leader>fb', fzf.buffers, { desc = 'Find buffers' })
  map('n', '<leader>fo', fzf.oldfiles, { desc = 'Find old files' })
  map('n', '<leader>sg', fzf.live_grep, { desc = 'Live grep' })
  map('n', '<leader>fh', fzf.helptags, { desc = 'Find help' })
  map('n', '<leader>fk', fzf.keymaps, { desc = 'Find keymaps' })
  map('n', '<leader>f?', fzf.builtin, { desc = 'Find pickers' })
  map('n', '<leader>sb', fzf.blines, { desc = 'Lines in buffer' })
  map('n', 'gO', fzf.lsp_document_symbols, { desc = 'Document symbols' })
  map('n', 'gW', fzf.lsp_workspace_symbols, { desc = 'Workspace symbols' })
  map({ 'n', 'x' }, 'gra', fzf.lsp_code_actions, { desc = 'Code actions' })
  map('n', 'gri', fzf.lsp_implementations, { desc = 'Implementations' })
  map('n', 'grr', fzf.lsp_references, { desc = 'References' })
  map('n', 'grt', fzf.lsp_typedefs, { desc = 'Type definitions' })
  map('n', 'gd', fzf.lsp_definitions, { desc = 'Definitions' })
  map('n', 'gD', fzf.lsp_declarations, { desc = 'Declarations' })
  map('n', '<leader>xd', fzf.diagnostics_document, { desc = 'Document diagnostics' })
  map('n', '<leader>xD', fzf.diagnostics_workspace, { desc = 'Workspace diagnostics' })

  vim.cmd.packadd 'grug-far.nvim'
  require('grug-far').setup {}
  map({ 'n', 'x' }, '<leader>sr', function()
    local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
    require('grug-far').open {
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
      },
    }
  end, { desc = 'Search and replace' })
end)

-- nvim-bqf (on quickfix filetype)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  once = true,
  callback = function()
    vim.cmd.packadd 'fzf'
    vim.cmd.packadd 'nvim-bqf'
    local bqf = require 'bqf'
    bqf.setup {}
    pcall(bqf.enable)
  end,
})

-- render-markdown (on markdown filetype)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  once = true,
  callback = function()
    vim.cmd.packadd 'render-markdown.nvim'
    require('render-markdown').setup {}
  end,
})
