local M = {}

function M.setup()
  require('mini.ai').setup {}
  require('mini.surround').setup {}
  require('mini.icons').setup {}
  MiniIcons.mock_nvim_web_devicons()
  require('mini.statusline').setup {}
  require('mini.tabline').setup {}
end

return M
