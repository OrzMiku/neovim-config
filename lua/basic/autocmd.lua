local augroup = require('lib.augroup').create
local config = require 'config'

local M = {}

local function apply_ft_configs(ft_configs)
  local grp = augroup 'user_filetype_config'
  vim.api.nvim_clear_autocmds { group = grp }

  for _, block in ipairs(ft_configs or {}) do
    vim.api.nvim_create_autocmd('FileType', {
      group = grp,
      pattern = block.ft,
      callback = function()
        for opt, value in pairs(block.opts or {}) do
          vim.opt_local[opt] = value
        end

        if block.on then
          block.on(vim.api.nvim_get_current_buf())
        end
      end,
    })
  end
end

function M.setup()
  local cfg = config.get_config()

  apply_ft_configs(cfg.ft_configs)
end

return M
