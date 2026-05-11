local M = {}

function M.setup()
  require('basic.vimconf').setup()
  require('basic.keymaps').setup()
  require('basic.autocmd').setup()
  require('basic.usercmd').setup()
end

return M
