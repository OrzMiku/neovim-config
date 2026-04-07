local M = {}

local opts = {
  number = true,
  relativenumber = true,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  clipboard = 'unnamedplus',
  undofile = true,
  smartcase = true,
  ignorecase = true,
  splitbelow = true,
  splitright = true,
  list = true,
  cursorline = true,
  scrolloff = 10,
  confirm = true,
}

function M.setup()
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end

  vim.cmd.packadd 'nvim.undotree'
  require('vim._core.ui2').enable {
    enable = true,
    msg = {
      targets = {
        progress = 'msg',
      },
    },
  }
end

return M
