local M = {}

function M.setup(userconfig)
  require('modules.basic-ui').setup(userconfig)
  require('modules.basic-clipboard').setup(userconfig)
  require('modules.basic-options').setup()
  require('modules.basic-keymaps').setup()
  require('modules.basic-autocmds').setup()

  vim.cmd.packadd 'nvim.difftool'
end

return M
