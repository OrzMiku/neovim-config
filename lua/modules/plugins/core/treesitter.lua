local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserFileType', { clear = true }),
    pattern = { '*' },
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft
      if not vim.treesitter.language.add(lang) then
        local available = require('nvim-treesitter').get_available()
        if vim.tbl_contains(available, lang) then
          require('nvim-treesitter').install(lang)
        end
      end
      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(args.buf, lang)
      end
    end,
  })
end

function M.textobjects_init()
  vim.g.no_plugin_maps = true
end

return M
