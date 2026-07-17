local ChimiTabline = {}
local H = {}

ChimiTabline.config = {
  show = 2,
  unnamed = '[No Name]',
}

H.default_config = vim.deepcopy(ChimiTabline.config)

ChimiTabline.setup = function(config)
  _G.ChimiTabline = ChimiTabline
  ChimiTabline.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  vim.o.showtabline = ChimiTabline.config.show
  vim.o.tabline = "%!v:lua.require('chimi.tabline').render()"
end

ChimiTabline.render = function()
  local current = vim.api.nvim_get_current_buf()
  local parts = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then
      local name = vim.api.nvim_buf_get_name(bufnr)
      name = (name ~= '' and vim.fn.fnamemodify(name, ':t') or ChimiTabline.config.unnamed):gsub('%%', '%%%%')
      local highlight = bufnr == current and '%#TabLineSel#' or '%#TabLine#'
      local modified = vim.bo[bufnr].modified and '*' or ''
      parts[#parts + 1] = highlight .. ' ' .. name .. modified .. ' '
    end
  end

  parts[#parts + 1] = '%#TabLineFill#%='
  return table.concat(parts)
end

return ChimiTabline
