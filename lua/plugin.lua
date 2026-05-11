local M = {}

function M.setup()
  require('basic.colorscheme').preload()

  vim.pack.add { 'https://github.com/zuqini/zpack.nvim' }
  require('zpack').setup {}

  require('basic.colorscheme').setup()
end

return M
