---@module 'lazy.core.config'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local langs = require 'modules.configs.langs'
    require('nvim-treesitter').install(langs.get_ts_parsers())
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('UserFileType', { clear = true }),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if not ft or ft == '' then
          return
        end
        local lang = vim.treesitter.language.get_lang(ft) or ft
        pcall(vim.treesitter.start, args.buf, lang)
      end,
    })
  end,
}
