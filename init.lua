-- Enable Ahead-of-Time bytecode compilation
if vim.loader then
  vim.loader.enable()
end

--------------------------------------------------------------------------------
--- 02 - After Lazy
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    vim.schedule(function()
      require 'modules.keymaps'
      require 'modules.options'
      require('modules.lsp').setup()
    end)
  end,
})

--------------------------------------------------------------------------------
--- 00 - Preload
--------------------------------------------------------------------------------
require('modules.preload').setup()

--------------------------------------------------------------------------------
--- 01 - Lazy
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://ghfast.top/github.com/folke/lazy.nvim.git'
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
}
