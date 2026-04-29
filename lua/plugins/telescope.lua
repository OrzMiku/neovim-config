local augroup = require('lib.augroup').create

local function telescope_builtin(name)
  return function()
    require('telescope.builtin')[name]()
  end
end

local function lsp_buf_setup(event)
  local bufnr = event.buf
  vim.keymap.set('n', 'grr', telescope_builtin 'lsp_references', { buffer = bufnr, desc = 'Telescope LSP References' })
  vim.keymap.set('n', 'gri', telescope_builtin 'lsp_implementations', { buffer = bufnr, desc = 'Telescope LSP Implementations' })
  vim.keymap.set('n', 'grd', telescope_builtin 'lsp_definitions', { buffer = bufnr, desc = 'Telescope LSP Definitions' })
  vim.keymap.set('n', 'gO', telescope_builtin 'lsp_document_symbols', { buffer = bufnr, desc = 'Telescope LSP Document Symbols' })
  vim.keymap.set('n', 'gW', telescope_builtin 'lsp_dynamic_workspace_symbols', { buffer = bufnr, desc = 'Telescope LSP Workspace Symbols' })
  vim.keymap.set('n', 'grt', telescope_builtin 'lsp_type_definitions', { buffer = bufnr, desc = 'Telescope LSP Type Definitions' })
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-lua/plenary.nvim',
  },
  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup 'UserLspAttach',
      callback = lsp_buf_setup,
    })
  end,
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
          },
          n = {
            ['<esc>'] = actions.close,
          },
        },
      },
    }
    telescope.load_extension 'fzf'
  end,
  cmd = 'Telescope',
  keys = {
    {
      '<leader>fs',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = 'Telescope find files',
    },
    {
      '<leader>fz',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Telescope live grep',
    },
    {
      '<leader>fb',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = 'Telescope buffers',
    },
    {
      '<leader>fh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = 'Telescope help tags',
    },
    {
      '<leader>fk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = 'Telescope keymaps',
    },
    {
      '<leader>fp',
      function()
        require('telescope.builtin').git_files()
      end,
      desc = 'Telescope git_files',
    },
    {
      '<leader>fo',
      function()
        require('telescope.builtin').oldfiles()
      end,
      desc = 'Telescope old_files',
    },
  },
}
