return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  dependencies = { 'nvim-mini/mini.icons' },
  opts = {
    fzf_colors = true,
    ui_select = {},
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find files',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Find buffers',
    },
    {
      '<leader>fo',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = 'Find old files',
    },
    {
      '<leader>sg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Live grep',
    },
    {
      '<leader>fh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = 'Find help',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Find keymaps',
    },
    {
      '<leader>f?',
      function()
        require('fzf-lua').builtin()
      end,
      desc = 'Find pickers',
    },
    {
      '<leader>sb',
      function()
        require('fzf-lua').blines()
      end,
      desc = 'Lines in buffer',
    },
    {
      'gO',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = 'Document symbols',
    },
    {
      'gW',
      function()
        require('fzf-lua').lsp_workspace_symbols()
      end,
      desc = 'Workspace symbols',
    },
    {
      'gra',
      function()
        require('fzf-lua').lsp_code_actions()
      end,
      mode = { 'n', 'x' },
      desc = 'Code actions',
    },
    {
      'gri',
      function()
        require('fzf-lua').lsp_implementations()
      end,
      desc = 'Implementations',
    },
    {
      'grr',
      function()
        require('fzf-lua').lsp_references()
      end,
      desc = 'References',
    },
    {
      'grt',
      function()
        require('fzf-lua').lsp_typedefs()
      end,
      desc = 'Type definitions',
    },
    {
      'gd',
      function()
        require('fzf-lua').lsp_definitions()
      end,
      desc = 'Definitions',
    },
    {
      'gD',
      function()
        require('fzf-lua').lsp_declarations()
      end,
      desc = 'Declarations',
    },
    {
      '<leader>xd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = 'Document diagnostics',
    },
    {
      '<leader>xD',
      function()
        require('fzf-lua').diagnostics_workspace()
      end,
      desc = 'Workspace diagnostics',
    },
  },
}
