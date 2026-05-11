local config = require 'config'

local M = {}

local function apply(colorscheme)
  if not colorscheme or colorscheme == '' then
    return
  end

  local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify(('Failed to load colorscheme %q: %s'):format(colorscheme, err), vim.log.levels.WARN)
  end
end

function M.preload()
  apply(config.get_config().features.colorscheme.preload)
end

function M.setup()
  apply(config.get_config().features.colorscheme.name)
end

return M
