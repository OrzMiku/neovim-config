local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add {
  gh 'yianwillis/vimcdoc', -- chinese helpdoc for vim
  gh 'neovim/nvim-lspconfig', -- lspconfig presets
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' }, -- only used to install treesitter parsers
  gh 'catppuccin/nvim', -- beautiful colorscheme
  gh 'folke/lazydev.nvim', -- lua_ls setup for neovim
  gh 'mason-org/mason.nvim', -- portable package manager
  gh 'nvim-telescope/telescope.nvim', -- fuzzy search
  gh 'nvim-telescope/telescope-fzf-native.nvim', -- fzf for telescope.nvim
  gh 'nvim-lua/plenary.nvim', -- required by telescope
}
vim.api.nvim_exec_autocmds('User', {
  pattern = 'AfterPackAdd',
})

vim.cmd.colorscheme 'catppuccin-nvim'

-- use schedule to avoid enabling lsp before nvim-lspconfig plugin is loaded
vim.schedule(function()
  vim.lsp.enable {
    'lua_ls',
    'vtsls',
  }
  require('lazydev').setup {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }
end)

require('mason').setup {}

do
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>fs', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>fz', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
  vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Telescope git_files' })
  vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old_files' })
  require('telescope').load_extension 'fzf'
end
