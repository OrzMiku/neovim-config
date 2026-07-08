--------------------------------------------------------------------------------
--- Preload
--------------------------------------------------------------------------------

require('config').setup()
local userconfig = require('config').get_config()

--------------------------------------------------------------------------------
--- Basic
--------------------------------------------------------------------------------

userconfig.hooks.before_basic()

require('modules.basic').setup(userconfig)

userconfig.hooks.after_basic()

--------------------------------------------------------------------------------
--- Plugins
--------------------------------------------------------------------------------

if not userconfig.features.enable_plugin then
  return
end

userconfig.hooks.before_plugin()

local gh = require('modules.plugin-util').gh

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    gh 'folke/lazy.nvim',
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = false,
  },
}

userconfig.hooks.after_plugin()
