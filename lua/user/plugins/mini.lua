local M = {}

function M.setup()
  require('mini.ai').setup {}
  require('mini.surround').setup {}
  require('mini.bracketed').setup {}
  require('mini.icons').setup {
    style = _G.UserConfig.have_nerd_font and 'glyph' or 'ascii',
  }
  MiniIcons.mock_nvim_web_devicons()
  require('mini.statusline').setup {}
  require('mini.tabline').setup {}
  require('mini.indentscope').setup {
    draw = {
      delay = 0,
      animation = require('mini.indentscope').gen_animation.none(),
    },
  }
  require('mini.pairs').setup {}
  require('mini.move').setup {}
  require('mini.notify').setup {}
end

return M
