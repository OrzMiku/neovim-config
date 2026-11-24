-- Colorscheme (immediate)
require('catppuccin').setup {}
vim.cmd.colorscheme 'catppuccin-nvim'

-- Icons (immediate, used by oil.nvim and others)
local icons = require 'mini.icons'
icons.setup {
  style = UserConfig.have_nerd_font and 'glyph' or 'ascii',
}
icons.mock_nvim_web_devicons()

-- Tabline & which-key (deferred after first draw)
vim.schedule(function()
  vim.cmd.packadd 'mini.tabline'
  require('mini.tabline').setup {}

  vim.cmd.packadd 'which-key.nvim'
  require('which-key').setup {
    spec = {
      { '<leader>b', group = 'buffer', icon = { icon = '󰈔', color = 'cyan' } },
      { '<leader>c', group = 'code', icon = { icon = '', color = 'orange' }, mode = { 'n', 'x' } },
      { '<leader>f', group = 'find', icon = { icon = '', color = 'green' } },
      { '<leader>g', group = 'git', icon = { icon = '', color = 'orange' }, mode = { 'n', 'x' } },
      { '<leader>s', group = 'search', icon = { icon = '', color = 'green' }, mode = { 'n', 'x' } },
      { '<leader>x', group = 'lists', icon = { icon = '', color = 'yellow' } },
      { '<leader>t', group = 'tools', icon = { icon = '', color = 'purple' } },
      { '<leader>y', icon = { icon = '', color = 'yellow' }, mode = { 'n', 'x' } },
      { '<leader>p', icon = { icon = '', color = 'green' }, mode = { 'n', 'x' } },
      { '[', group = 'previous', icon = { icon = '', color = 'blue' } },
      { ']', group = 'next', icon = { icon = '', color = 'blue' } },
      { 'g', group = 'goto', icon = { icon = '', color = 'blue' } },
    },
  }
end)

-- Indentscope (on first buffer)
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.cmd.packadd 'mini.indentscope'
    require('mini.indentscope').setup {}
  end,
})
