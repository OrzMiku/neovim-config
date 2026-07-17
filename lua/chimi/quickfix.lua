local ChimiQuickfix = {}
local H = {}

ChimiQuickfix.config = {
  mappings = {
    toggle_quickfix = '<leader>xq',
    toggle_loclist = '<leader>xl',
    previous_quickfix = '[q',
    next_quickfix = ']q',
    previous_loclist = '[l',
    next_loclist = ']l',
  },
}

H.default_config = vim.deepcopy(ChimiQuickfix.config)

ChimiQuickfix.setup = function(config)
  _G.ChimiQuickfix = ChimiQuickfix
  ChimiQuickfix.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  local mappings = ChimiQuickfix.config.mappings

  H.map(mappings.toggle_quickfix, ChimiQuickfix.toggle_quickfix, 'Toggle quickfix')
  H.map(mappings.toggle_loclist, ChimiQuickfix.toggle_loclist, 'Toggle location list')
  H.map(mappings.previous_quickfix, vim.cmd.cprevious, 'Previous quickfix item')
  H.map(mappings.next_quickfix, vim.cmd.cnext, 'Next quickfix item')
  H.map(mappings.previous_loclist, vim.cmd.lprevious, 'Previous location item')
  H.map(mappings.next_loclist, vim.cmd.lnext, 'Next location item')
end

ChimiQuickfix.toggle_quickfix = function()
  local open = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  H.try(open and vim.cmd.cclose or vim.cmd.copen)
end

ChimiQuickfix.toggle_loclist = function()
  local open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
  H.try(open and vim.cmd.lclose or vim.cmd.lopen)
end

H.map = function(lhs, rhs, desc)
  if lhs and lhs ~= '' then
    vim.keymap.set('n', lhs, rhs, { desc = desc })
  end
end

H.try = function(action)
  local ok, err = pcall(action)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

return ChimiQuickfix
