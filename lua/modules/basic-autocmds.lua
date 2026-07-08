local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserFtIndent2', { clear = true }),
    pattern = {
      'nix',
      'lua',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'html',
      'css',
      'less',
      'scss',
      'sass',
      'json',
    },
    callback = function()
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
    end,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspCompletion', { clear = true }),
    callback = function(ev)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
      if client:supports_method 'textDocument/completion' then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspInlineCompletion', { clear = true }),
    callback = function(ev)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
      if client:supports_method('textDocument/inlineCompletion', ev.buf) then
        vim.lsp.inline_completion.enable(true, { bufnr = ev.buf })
        vim.keymap.set('i', '<C-F>', vim.lsp.inline_completion.get, { desc = 'LSP: accept inline completion', buf = ev.buf })
        vim.keymap.set('i', '<C-G>', vim.lsp.inline_completion.select, { desc = 'LSP: switch inline completion', buf = ev.buf })
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspProgress', {
    group = vim.api.nvim_create_augroup('UserLspProgressNotify', { clear = true }),
    callback = function(ev)
      local value = ev.data.params.value
      vim.api.nvim_echo({ { value.message or 'done' } }, false, {
        id = 'lsp.' .. ev.data.params.token,
        kind = 'progress',
        source = 'vim.lsp',
        title = value.title,
        status = value.kind ~= 'end' and 'running' or 'success',
        percent = value.percentage,
      })
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserTSAutoStart', { clear = true }),
    pattern = '*',
    callback = function(ev)
      local lang = ev.match
      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(ev.buf, lang)
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('UserDisableAutocomplete', { clear = true }),
    callback = function(ev)
      if vim.bo[ev.buf].buftype ~= '' then
        vim.bo[ev.buf].autocomplete = false
      end
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserQuickFixWrap', { clear = true }),
    pattern = { 'qf' },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
    end,
  })
end

return M
