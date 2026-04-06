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

vim.api.nvim_create_autocmd('User', {
  pattern = 'AfterPackAdd',
  group = augroup.after_pack_add,
  callback = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = augroup.user_file_type,
      callback = function(ev)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(ev.buf) then
            return
          end
          local ft = vim.bo[ev.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          local nvim_treesitter = require 'nvim-treesitter'
          -- automatically install missing treesitter parsers
          if _G.UserConfig.treesitter.auto_install_by_ft.enable and not vim.treesitter.language.add(lang) then
            if vim.tbl_contains(_G.UserConfig.treesitter.auto_install_by_ft.ignore, ft) then
              return
            end
            local available = nvim_treesitter.get_available()
            -- check if lang is among the available parsers
            if vim.tbl_contains(available, lang) then
              nvim_treesitter.install(lang):wait(300000)
            end
          end
          -- automatically start treesitter highlighting
          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
          end
        end)
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup.user_pack_changed,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
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
