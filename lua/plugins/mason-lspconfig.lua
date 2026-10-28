local unmanaged = {}

return {
  'mason-org/mason-lspconfig.nvim',
  opts = function()
    local managed = require('mason-lspconfig').get_mappings().lspconfig_to_package
    local ensure_installed, exclude = {}, {}
    unmanaged = {}

    for name, enabled in pairs(UserConfig.lsp) do
      if managed[name] then
        table.insert(enabled and ensure_installed or exclude, name)
      else
        unmanaged[name] = enabled
      end
    end

    return {
      ensure_installed = ensure_installed,
      automatic_enable = { exclude = exclude },
    }
  end,
  config = function(_, opts)
    require('mason-lspconfig').setup(opts)

    for name, enabled in pairs(unmanaged) do
      vim.lsp.enable(name, enabled)
    end
  end,
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
}
