local function telescope_builtin(name)
  return function()
    require('telescope.builtin')[name]()
  end
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-lua/plenary.nvim',
  },
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
    { '<leader>fs', telescope_builtin 'find_files',                    desc = 'Telescope find files' },
    { '<leader>fz', telescope_builtin 'live_grep',                     desc = 'Telescope live grep' },
    { '<leader>fb', telescope_builtin 'buffers',                       desc = 'Telescope buffers' },
    { '<leader>fh', telescope_builtin 'help_tags',                     desc = 'Telescope help tags' },
    { '<leader>fk', telescope_builtin 'keymaps',                       desc = 'Telescope keymaps' },
    { '<leader>fp', telescope_builtin 'git_files',                     desc = 'Telescope git_files' },
    { '<leader>fo', telescope_builtin 'oldfiles',                      desc = 'Telescope old_files' },
    { 'grr',        telescope_builtin 'lsp_references',                desc = 'Telescope LSP References' },
    { 'gri',        telescope_builtin 'lsp_implementations',           desc = 'Telescope LSP Implementations' },
    { 'grd',        telescope_builtin 'lsp_definitions',               desc = 'Telescope LSP Definitions' },
    { 'gO',         telescope_builtin 'lsp_document_symbols',          desc = 'Telescope LSP Document Symbols' },
    { 'gW',         telescope_builtin 'lsp_dynamic_workspace_symbols', desc = 'Telescope LSP Workspace Symbols' },
    { 'grt',        telescope_builtin 'lsp_type_definitions',          desc = 'Telescope LSP Type Definitions' },
  },
}
