local M = {}

function M.build()
  vim.fn['fzf#install']()
end

return M
