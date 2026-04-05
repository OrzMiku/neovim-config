local M = {}

function M.markdown_preview_build()
  vim.cmd [[Lazy load markdown-preview.nvim]]
  vim.fn['mkdp#util#install']()
end

return M
