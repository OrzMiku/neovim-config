local user_config = require('config').get_config()

return {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup {}
    require('mini.surround').setup {}
    require('mini.bracketed').setup {}
    require('mini.icons').setup {
      style = user_config.features.have_nerd_font and 'glyph' or 'ascii',
    }
    MiniIcons.mock_nvim_web_devicons()

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

    require('mini.statusline').setup {}
    require('mini.tabline').setup {}
    require('mini.indentscope').setup {
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none(),
      },
    }
    require('mini.pairs').setup {}
    require('mini.move').setup {}
    require('mini.notify').setup {}
    require('mini.trailspace').setup {}
  end,
  event = 'VeryLazy',
}
