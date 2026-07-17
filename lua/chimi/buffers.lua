local ChimiBuffers = {}
local H = {}

ChimiBuffers.config = {
  mappings = {
    previous = '[b',
    next = ']b',
  },
}

H.default_config = vim.deepcopy(ChimiBuffers.config)

ChimiBuffers.setup = function(config)
  _G.ChimiBuffers = ChimiBuffers
  ChimiBuffers.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  local mappings = ChimiBuffers.config.mappings

  H.map(mappings.previous, '<cmd>bprevious<cr>', 'Previous buffer')
  H.map(mappings.next, '<cmd>bnext<cr>', 'Next buffer')
end

H.map = function(lhs, rhs, desc)
  if lhs and lhs ~= '' then
    vim.keymap.set('n', lhs, rhs, { desc = desc })
  end
end

return ChimiBuffers
