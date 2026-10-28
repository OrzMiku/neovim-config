return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = { 'catppuccin/nvim', 'nvim-mini/mini.icons' },
  opts = function(_, opts)
    if type(opts.highlights) ~= 'function' then
      local theme = require('catppuccin.special.bufferline').get_theme()
      opts.highlights = vim.tbl_deep_extend('keep', opts.highlights or {}, type(theme) == 'function' and theme() or theme)
    end
    opts.options = vim.tbl_deep_extend('keep', opts.options or {}, { always_show_bufferline = false })
  end,
  keys = {
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle buffer pin' },
    { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Delete non-pinned buffers' },
    { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Delete buffers right' },
    { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Delete buffers left' },
    { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Pick buffer' },
  },
}
