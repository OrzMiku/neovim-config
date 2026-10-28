return {
  'nvim-mini/mini.icons',
  lazy = true,
  opts = {
    style = UserConfig.have_nerd_font and 'glyph' or 'ascii',
  },
  config = function(_, opts)
    local icons = require 'mini.icons'
    icons.setup(opts)
    icons.mock_nvim_web_devicons()
  end,
}
