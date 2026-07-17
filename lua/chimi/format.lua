local ChimiFormat = {}
local H = {}

ChimiFormat.config = {
  mapping = '<leader>cf',
}

H.default_config = vim.deepcopy(ChimiFormat.config)

ChimiFormat.setup = function(config)
  _G.ChimiFormat = ChimiFormat
  ChimiFormat.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

  local mapping = ChimiFormat.config.mapping
  if mapping and mapping ~= '' then
    vim.keymap.set({ 'n', 'x' }, mapping, ChimiFormat.format, { desc = 'Code format' })
  end
end

ChimiFormat.format = function()
  vim.lsp.buf.format {}
end

return ChimiFormat
