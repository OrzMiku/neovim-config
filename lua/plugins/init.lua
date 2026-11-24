local function gh(repo)
  return 'https://github.com/' .. repo
end

-- Set global options required before plugin/ scripts are sourced
vim.g['chezmoi#use_tmp_buffer'] = true

-- Eager plugins: needed before first draw / on startup
vim.pack.add({
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },
  gh 'nvim-mini/mini.icons',
  gh 'stevearc/oil.nvim',
  gh 'alker0/chezmoi.vim',
}, { load = true })

-- Deferred & event-loaded plugins: installed/tracked by vim.pack, packadd'd later
vim.pack.add({
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'romus204/tree-sitter-manager.nvim',
  gh 'rafamadriz/friendly-snippets',
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
  gh 'lewis6991/gitsigns.nvim',
  gh 'nvim-mini/mini.indentscope',
  gh 'nvim-mini/mini.tabline',
  gh 'nvim-mini/mini.move',
  gh 'folke/which-key.nvim',
  gh 'stevearc/conform.nvim',
  gh 'ibhagwan/fzf-lua',
  gh 'MagicDuck/grug-far.nvim',
  gh 'junegunn/fzf',
  gh 'kevinhwang91/nvim-bqf',
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'NeogitOrg/neogit',
  gh 'esmuellert/codediff.nvim',
  gh 'wakatime/vim-wakatime',
  gh 'brianhuster/live-preview.nvim',
  gh 'nabekou29/open-by-http.nvim',
}, { load = function() end })

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Update vim.pack plugins' })

vim.api.nvim_create_user_command('PackClean', function()
  local unused = vim
    .iter(vim.pack.get())
    :filter(function(p)
      return not p.active
    end)
    :map(function(p)
      return p.spec.name
    end)
    :totable()
  if #unused == 0 then
    vim.notify('No unused plugins to remove', vim.log.levels.INFO, { title = 'vim.pack' })
    return
  end
  vim.pack.del(unused)
end, { desc = 'Remove unused vim.pack plugins' })

vim.keymap.set('n', '<leader>tp', '<cmd>PackUpdate<cr>', { desc = 'Pack update' })

require 'plugins.ui'
require 'plugins.editor'
require 'plugins.lsp'
require 'plugins.git'
require 'plugins.tools'
