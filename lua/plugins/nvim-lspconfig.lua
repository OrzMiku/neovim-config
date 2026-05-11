return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason-org/mason.nvim' },
  config = function()
    require('basic.lsp').setup()
  end,
  event = { 'BufReadPre', 'BufNewFile' },
}
