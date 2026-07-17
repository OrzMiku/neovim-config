local ChimiExplorer = {}
local H = {}

ChimiExplorer.config = {
  mapping = '-',
}

H.default_config = vim.deepcopy(ChimiExplorer.config)

ChimiExplorer.setup = function(config)
  _G.ChimiExplorer = ChimiExplorer
  ChimiExplorer.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  vim.cmd.packadd 'netrw'

  local mapping = ChimiExplorer.config.mapping
  if mapping and mapping ~= '' then
    vim.keymap.set('n', mapping, '<cmd>Explore<cr>', { desc = 'Open parent directory' })
  end
end

return ChimiExplorer
