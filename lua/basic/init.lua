local M = {}

function M.setup()
  require('basic.options').setup()
  require('basic.keymaps').setup()
  require('basic.autocmd').setup()
  require('basic.usercmd').setup()
end

return M
