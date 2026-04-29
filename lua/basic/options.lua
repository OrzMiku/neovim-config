local M = {}

local user_config = require('config').get_config()

function M.setup()
  for k, v in pairs(user_config.opts) do
    vim.opt[k] = v
  end

  if user_config.features.clipboard_osc52 then
    require('lib.osc52').setup()
  end

  require('vim._core.ui2').enable {
    enable = user_config.features.ui2,
  }

  vim.filetype.add(user_config.custom_filetypes)
  vim.cmd.packadd 'nvim.undotree'
end

return M
