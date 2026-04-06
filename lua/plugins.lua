local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add {
  gh 'yianwillis/vimcdoc', -- chinese helpdoc for vim
  gh 'neovim/nvim-lspconfig', -- lspconfig presets
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' }, -- only used to install treesitter parsers
  gh 'catppuccin/nvim', -- beautiful colorscheme
  gh 'folke/lazydev.nvim', -- lua_ls setup for neovim
}

vim.cmd.colorscheme 'catppuccin-nvim'

-- use schedule to avoid enabling lsp before nvim-lspconfig plugin is loaded
vim.schedule(function()
  vim.lsp.enable {
    'lua_ls',
  }
  require('lazydev').setup {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }
end)
