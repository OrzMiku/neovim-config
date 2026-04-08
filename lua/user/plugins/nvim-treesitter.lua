local M = {}

local augroup = require('user.lib.augroup').create

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'UserFileType',
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
end
return M
