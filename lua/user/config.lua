local M = {}

function M.setup()
  _G.UserConfig = {
    have_nerd_font = true,
    treesitter = {
      auto_install_by_ft = {
        enable = false,
        ignore = {
          'vue',
          'typescriptreact',
          'javascriptreact',
          'tex',
        },
      },
    },
  }
end

return M
