local M = {}

function M.setup()
  _G.UserConfig = {
    clipboard_osc52 = true,
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
