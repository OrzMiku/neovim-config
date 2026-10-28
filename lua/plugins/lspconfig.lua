return {
  'neovim/nvim-lspconfig',
  lazy = false,
  opts = vim.deepcopy(UserConfig.lsp),
  config = function(_, opts)
    for name, config in pairs(opts.servers or {}) do
      if config == false then
        vim.lsp.enable(name, false)
      elseif config == true then
        vim.lsp.enable(name)
      else
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end
  end,
}
