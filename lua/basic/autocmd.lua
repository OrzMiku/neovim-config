local M = {}

local user_config = require('config').get_config()
local augroup = require('lib.augroup').create

function M.setup()
  -- FileType specific configurations
  for _, block in ipairs(user_config.ft_configs) do
    local grp = augroup 'UserFileType'
    vim.api.nvim_create_autocmd('FileType', {
      group = grp,
      pattern = block.ft,
      callback = function()
        for opt, value in pairs(block.opts) do
          vim.opt_local[opt] = value
        end
        if block.on then
          block.on(vim.api.nvim_get_current_buf())
        end
      end,
    })
  end
end

return M
