local M = {}

local function paste()
  return {
    vim.split(vim.fn.getreg '', '\n'),
    vim.fn.getregtype '',
  }
end

function M.setup(userconfig)
  if not userconfig.features.clipboard_osc52 or not vim.env.SSH_TTY then
    return
  end

  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end

return M
