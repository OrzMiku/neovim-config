local M = {}

function M.env_flag(name, default)
  local value = vim.env[name]
  if value == nil or value == '' then
    return default
  end
  return value ~= '0' and value ~= 'false'
end

return M
