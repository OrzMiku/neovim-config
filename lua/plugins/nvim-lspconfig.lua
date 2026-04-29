local user_config = require('config').get_config()

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason-org/mason.nvim' },
  config = function()
    for lsp_config_name, is_enabled in pairs(user_config.features.lsp_enable) do
      if is_enabled then
        vim.lsp.enable(lsp_config_name)
      end
    end
  end,
  event = { 'BufReadPre', 'BufNewFile' },
}
