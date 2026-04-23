local M = {}

local default_config = {
  opts = {
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
  },
  neovide_opts = {
    guifont = 'Maple Mono NF CN',
  },
  clipboard_osc52 = true,
  have_nerd_font = true,
}

local config = vim.deepcopy(default_config)

function M.setup(user_config)
  config = vim.tbl_deep_extend('force', vim.deepcopy(default_config), user_config or {})
end

function M.get_config()
  return vim.deepcopy(config)
end

return M
