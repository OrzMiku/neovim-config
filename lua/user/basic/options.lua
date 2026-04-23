local M = {}

local user_config = require('user.config').get_config()

function M.setup()
  for k, v in pairs(user_config.opts) do
    vim.opt[k] = v
  end

  if user_config.features.clipboard_osc52 then
    require('user.lib.osc52').setup()
  end

  vim.filetype.add(user_config.custom_filetypes)
  vim.cmd.packadd 'nvim.undotree'
end

return M
