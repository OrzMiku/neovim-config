return {
  'folke/which-key.nvim',
  cmd = 'WhichKey',
  dependencies = { 'nvim-mini/mini.icons' },
  event = 'VeryLazy',
  opts = {
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
  },
}
