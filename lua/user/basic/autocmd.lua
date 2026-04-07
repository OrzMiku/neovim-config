local M = {}

local augroup = require('user.lib.augroup').create
local lsp_buf_setup = require('user.basic.keymaps').lsp_buf_setup

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass' },
    group = augroup 'UserFileType',
    callback = function()
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
    end,
  })

  vim.api.nvim_create_autocmd('LspProgress', {
    group = augroup 'UserLspProgress',
    callback = function(ev)
      local value = ev.data.params.value
      vim.api.nvim_echo({ { value.message or 'done' } }, false, {
        id = 'lsp.' .. ev.data.client_id,
        kind = 'progress',
        source = 'vim.lsp',
        title = value.title,
        status = value.kind ~= 'end' and 'running' or 'success',
        percent = value.percentage,
      })
    end,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup 'UserLspAttach',
    callback = lsp_buf_setup,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'AfterPackAdd',
    group = augroup 'UserAfterPackAdd',
    callback = function(ev)
      vim.lsp.enable {
        'lua_ls',
        'vtsls',
      }
    end,
  })
end

return M
