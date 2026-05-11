local features = require('config').get_config().features

return {
  { 'nvim-mini/mini.ai', opts = {}, event = 'VeryLazy' },
  { 'nvim-mini/mini.surround', opts = {}, event = 'VeryLazy' },
  {
    'nvim-mini/mini.icons',
    opts = {
      style = features.have_nerd_font and 'glyph' or 'ascii',
    },
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
    event = 'VeryLazy',
  },
  {
    'nvim-mini/mini.files',
    opts = {},
    config = function()
      require('mini.files').setup {}
      vim.keymap.set('n', '<leader>e', function()
        MiniFiles.open()
      end, { desc = 'Open File Explorer' })

      local set_cwd = function()
        local path = (MiniFiles.get_fs_entry() or {}).path
        if path == nil then
          return vim.notify 'Cursor is not on valid entry'
        end
        vim.fn.chdir(vim.fs.dirname(path))
        MiniFiles.open()
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local b = args.data.buf_id
          vim.keymap.set('n', 'g~', set_cwd, { buffer = b, desc = 'Set cwd' })
        end,
      })
    end,
  },
  { 'nvim-mini/mini.statusline', opts = {}, event = 'VeryLazy' },
  { 'nvim-mini/mini.tabline', opts = {}, event = 'VeryLazy' },
  {
    'nvim-mini/mini.indentscope',
    config = function()
      require('mini.indentscope').setup {
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      }
    end,
    event = 'VeryLazy',
  },
  { 'nvim-mini/mini.pairs', opts = {}, event = 'VeryLazy' },
  { 'nvim-mini/mini.move', opts = {}, event = 'VeryLazy' },
  { 'nvim-mini/mini.notify', opts = {}, event = 'VeryLazy' },
}
