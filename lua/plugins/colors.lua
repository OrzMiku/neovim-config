local gh = require('modules.plugin-util').gh

return {
  {
    url = gh 'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        auto_integrations = true,
      }
      vim.cmd.colorscheme 'catppuccin-nvim'
    end,
  },
}
