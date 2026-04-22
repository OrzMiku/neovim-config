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

  vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup 'UserLspAttach',
    callback = lsp_buf_setup,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'AfterPackAdd',
    group = augroup 'UserAfterPackAdd',
    callback = function()
      vim.filetype.add {
        extension = {
          vsh = 'glsl',
          fsh = 'glsl',
          vert = 'glsl',
          frag = 'glsl',
        },
      }
      vim.lsp.enable {
        'lua_ls', -- lua-language-server
        'vtsls', -- vtsls
        'vue_ls', -- vue-language-server
        'texlab', -- texlab
        'clangd', -- clangd
        'pyright', -- pyright
        -- 'basepyright', -- basepyright
      }
    end,
  })
end

return M
