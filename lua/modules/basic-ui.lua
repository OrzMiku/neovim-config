local M = {}

function M.setup(userconfig)
  vim.cmd.colorscheme 'catppuccin'

  if userconfig.features.ui2 then
    require('vim._core.ui2').enable {
      enable = true,
      msg = {
        targets = {
          default = 'cmd',
          progress = 'msg',
        },
      },
    }
  end
end

return M
