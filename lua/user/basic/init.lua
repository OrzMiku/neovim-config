local M = {}

function M.setup()
  require('vim._core.ui2').enable {
    enable = true, -- Whether to enable or disable the UI.
  }
  require('user.basic.options').setup()
  require('user.basic.keymaps').setup()
  require('user.basic.autocmd').setup()
  require('user.basic.usercmd').setup()
end

return M
