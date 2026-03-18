local M = {}

local RawIconSpec = {
  [vim.diagnostic.severity.ERROR] = {
    icon = ' ',
    hl = 'DiagnosticError',
  },
  [vim.diagnostic.severity.WARN] = {
    icon = ' ',
    hl = 'DiagnosticWarn',
  },
  [vim.diagnostic.severity.INFO] = {
    icon = ' ',
    hl = 'DiagnosticInfo',
  },
  [vim.diagnostic.severity.HINT] = {
    icon = '󰌵 ',
    hl = 'DiagnosticHint',
  },
}

local IconTable = (function()
  local ret = {}
  for severity, spec in pairs(RawIconSpec) do
    ret[severity] = spec.icon
  end
  return ret
end)()

---@type vim.diagnostic.Opts
local DiagnosticsConfig = {
  virtual_lines = true,
  underline = false,
  signs = {
    text = IconTable,
  },
  update_in_insert = false,
  float = {
    border = 'rounded',
    header = '',
    source = true,
    prefix = function(diag)
      local map = RawIconSpec
      local spec = map[diag.severity]
      return spec.icon .. ' ', spec.hl
    end,
  },
}

function M.setup()
  vim.diagnostic.config(DiagnosticsConfig)
end

return M
