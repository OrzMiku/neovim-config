local M = {}

function M.catppuccin_config(_, opts)
  require('catppuccin').setup(opts)
  vim.cmd.colorscheme 'catppuccin-mocha'
end

return M
