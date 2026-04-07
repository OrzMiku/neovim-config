local M = {}

function M.setup()
  require('user.basic.options').setup()
  require('user.basic.keymaps').setup()
  require('user.basic.autocmd').setup()
end

return M
