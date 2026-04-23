local M = {}

local user_config = require('user.config').get_config()
local augroup = require('user.lib.augroup').create

function M.setup()
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

  vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup 'UserLspAttach',
    callback = require('user.basic.keymaps').lsp_keymap,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'AfterPackAdd',
    group = augroup 'UserAfterPackAdd',
    callback = function()
      for lsp_config_name, is_enabled in pairs(user_config.features.lsp_enable) do
        if is_enabled then
          vim.lsp.enable(lsp_config_name)
        end
      end
    end,
  })
end

return M
