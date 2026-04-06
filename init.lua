_G.UserConfig = {
  treesitter = {
    auto_install_by_ft = {
      enable = false,
      ignore = {
        'vue',
        'typescriptreact',
        'javascriptreact',
      },
    },
  },
}

require 'options'
require 'keymaps'
require 'autocmd'
require 'plugins'
