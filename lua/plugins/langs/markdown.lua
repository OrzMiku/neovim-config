---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.cmd [[Lazy load markdown-preview.nvim]]
      vim.fn['mkdp#util#install']()
    end,
  },
}
