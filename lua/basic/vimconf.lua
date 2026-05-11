local config = require 'config'

local M = {}

function M.setup()
  local cfg = config.get_config()

  for scope, values in pairs(cfg.vim or {}) do
    for key, value in pairs(values) do
      if type(vim[scope][key]) == 'function' then
        vim[scope][key](value)
      else
        vim[scope][key] = value
      end
    end
  end

  if cfg.features.clipboard_osc52 then
    require('lib.osc52').setup()
  end

  require('vim._core.ui2').enable {
    enable = cfg.features.ui2,
  }
end

return M
