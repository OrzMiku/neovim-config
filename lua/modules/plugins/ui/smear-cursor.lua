local M = {}

function M.enabled()
  return not vim.g.neovide
end

return M
