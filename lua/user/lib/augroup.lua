local M = {}

M.augroup = {}

M.create = function(name)
  if M.augroup[name] then
    return M.augroup[name]
  end
  M.augroup[name] = vim.api.nvim_create_augroup(name, { clear = true })
  return M.augroup[name]
end

return M
