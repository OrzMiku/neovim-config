if vim.loader then
  vim.loader.enable()
end

----------------------------------------
--- 02 - After LazyVimStarted
----------------------------------------
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    require('modules.lsp').setup()
    require 'modules.options'
    require 'modules.keymaps'
    require('modules.diagnostics').setup()
  end,
})

----------------------------------------
--- 00 - Preload
----------------------------------------
require('modules.preload').setup()

----------------------------------------
--- 01 - Lazy
----------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim: \n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup {
  spec = {
    { import = 'plugins' },
    { import = 'plugins.langs' },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      ---@type string[]
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'zipPlugin',
        'netrwPlugin',
        'tutor',
      },
    },
  },
}
