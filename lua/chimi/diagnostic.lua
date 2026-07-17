local ChimiDiagnostic = {}
local H = {}

ChimiDiagnostic.config = {
  virtual_text = false,
  virtual_lines = { current_line = true },
  mappings = {
    to_quickfix = '<leader>xQ',
    to_loclist = '<leader>xL',
  },
}

H.default_config = vim.deepcopy(ChimiDiagnostic.config)

ChimiDiagnostic.setup = function(config)
  _G.ChimiDiagnostic = ChimiDiagnostic
  ChimiDiagnostic.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  config = ChimiDiagnostic.config

  vim.diagnostic.config {
    virtual_text = config.virtual_text,
    virtual_lines = config.virtual_lines,
  }

  local mappings = config.mappings
  H.map(mappings.to_quickfix, vim.diagnostic.setqflist, 'Diagnostics to quickfix')
  H.map(mappings.to_loclist, vim.diagnostic.setloclist, 'Diagnostics to loclist')
end

H.map = function(lhs, rhs, desc)
  if lhs and lhs ~= '' then
    vim.keymap.set('n', lhs, rhs, { desc = desc })
  end
end

return ChimiDiagnostic
