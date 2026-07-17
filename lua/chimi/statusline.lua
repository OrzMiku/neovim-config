local ChimiStatusline = {}
local H = {}

ChimiStatusline.config = {
  suffix = " [%{&filetype ==# '' ? 'none' : &filetype}|%{&fileformat}]",
}

H.default_config = vim.deepcopy(ChimiStatusline.config)

ChimiStatusline.setup = function(config)
  _G.ChimiStatusline = ChimiStatusline
  ChimiStatusline.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  local suffix = ChimiStatusline.config.suffix

  if suffix ~= '' and not vim.o.statusline:find(suffix, 1, true) then
    vim.opt.statusline = vim.opt.statusline + suffix
  end
end

return ChimiStatusline
