local config = require 'config'

local M = {}

function M.setup()
  for lsp_config_name, is_enabled in pairs(config.get_config().features.lsp_enable or {}) do
    if is_enabled then
      vim.lsp.enable(lsp_config_name)
    end
  end
end

return M
