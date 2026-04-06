local augroup = {
  user_file_type = vim.api.nvim_create_augroup('UserFileType', { clear = true }),
  user_pack_changed = vim.api.nvim_create_augroup('UserPackChanged', { clear = true }),
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass' },
  group = augroup.user_file_type,
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup.user_file_type,
  callback = function(ev)
    vim.schedule(function()
      local ft = vim.bo[ev.buf].filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft
      vim.cmd.packadd 'nvim-treesitter'
      local nvim_treesitter = require 'nvim-treesitter'
      -- automatically install missing treesitter parsers
      if _G.UserConfig.treesitter.auto_install and not vim.treesitter.language.add(lang) then
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
  end,
})
