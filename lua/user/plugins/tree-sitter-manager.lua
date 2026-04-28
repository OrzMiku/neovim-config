local M = {}

function M.setup()
  require('tree-sitter-manager').setup { highlight = false }
  -- This is a temporary solution, pending an upstream fix in tree-sitter-manager.
  vim.api.nvim_create_autocmd('FileType', {
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })
end

return M
