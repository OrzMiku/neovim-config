local ChimiLsp = {}
local H = {}

ChimiLsp.config = {
  servers = { 'lua_ls' },
  mappings = {
    definition = 'gd',
    declaration = 'gD',
  },
}

H.default_config = vim.deepcopy(ChimiLsp.config)

ChimiLsp.setup = function(config)
  _G.ChimiLsp = ChimiLsp
  ChimiLsp.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  config = ChimiLsp.config

  vim.lsp.enable(config.servers)

  H.map(config.mappings.definition, vim.lsp.buf.definition, 'Definitions')
  H.map(config.mappings.declaration, vim.lsp.buf.declaration, 'Declarations')
end

H.map = function(lhs, rhs, desc)
  if lhs and lhs ~= '' then
    vim.keymap.set('n', lhs, rhs, { desc = desc })
  end
end

return ChimiLsp
