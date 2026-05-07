--------------------------------------------------------------------------------
--- CONFIG SETUP
--------------------------------------------------------------------------------
require('config').setup()

--------------------------------------------------------------------------------
--- BASIC SETUP
--- Core Neovim configuration, excluding plugin configurations.
--------------------------------------------------------------------------------
require('basic').setup()
require('basic.colorscheme').preload()

--------------------------------------------------------------------------------
--- PLUGIN SETUP
--- All plugin-related configurations.
--------------------------------------------------------------------------------
vim.pack.add { 'https://github.com/zuqini/zpack.nvim' }
require('zpack').setup {}
require('basic.colorscheme').setup()
