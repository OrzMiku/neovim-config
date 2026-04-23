local M = {}

local user_config = require('user.config').get_config()

function M.setup()
  for k, v in pairs(user_config.opts) do
    vim.opt[k] = v
  end

  if user_config.clipboard_osc52 then
    require('user.lib.osc52').setup()
  end

  if vim.g.neovide then
    for k, v in pairs(user_config.neovide_opts) do
      vim.opt[k] = v
    end
  end

  vim.cmd.packadd 'nvim.undotree'
end

return M
