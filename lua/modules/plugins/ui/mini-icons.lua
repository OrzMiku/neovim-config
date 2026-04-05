local M = {}

function M.config()
  require('mini.icons').setup {
    style = vim.g.have_nerd_font and 'glyph' or 'ascii',
  }
  MiniIcons.mock_nvim_web_devicons()
end

return M
