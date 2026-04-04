local M = {
  config = {
    undotree = true,
    inline_completion = true,
  },
}

local enable_undotree = function()
  vim.cmd 'packadd nvim.undotree'
  vim.keymap.set('n', '<leader>u', require('undotree').open, { desc = 'Open undotree' })
end

local enable_inline_completion = function()
  vim.lsp.enable 'copilot'
  vim.lsp.inline_completion.enable()
  vim.keymap.set('i', '<C-.>', function()
    if not vim.lsp.inline_completion.get() then
      return '<C-.>'
    end
  end, { desc = 'Accept the current line inline completion' })
end

function M.setup()
  if M.config.undotree then
    enable_undotree()
  end
  if M.config.inline_completion then
    enable_inline_completion()
  end
end

return M
