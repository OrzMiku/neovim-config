local augroup = {
  user_file_type = vim.api.nvim_create_augroup('UserFileType', { clear = true }),
  user_pack_changed = vim.api.nvim_create_augroup('UserPackChanged', { clear = true }),
  user_lsp_progress = vim.api.nvim_create_augroup('UserLspProgress', { clear = true }),
  after_pack_add = vim.api.nvim_create_augroup('AfterPackAdd', { clear = true }),
  user_lsp_attach = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass' },
  group = augroup.user_file_type,
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup.user_pack_changed,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      if vim.fn.executable 'make' == 1 then
        vim.system({ 'make' }, { cwd = ev.data.path }):wait(300000)
      elseif vim.fn.executable 'mingw32-make' == 1 then
        vim.system({ 'mingw32-make' }, { cwd = ev.data.path }):wait(300000)
      end
    end
  end,
})

vim.api.nvim_create_autocmd('LspProgress', {
  group = augroup.user_lsp_progress,
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
  group = augroup.user_lsp_attach,
  callback = function(ev)
    require('modules.lsp').lsp_buf_setup(ev)
  end,
})
