local config = require 'config'

local M = {}

function M.setup()
  local cfg = config.get_config()

  for _, keymap in ipairs(cfg.keymaps or {}) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4] or {})
  end
end

return M
