local gh = require('modules.plugin-util').gh

local function fzf_call(method)
  return function()
    require('fzf-lua')[method]()
  end
end

return {
  {
    url = gh 'ibhagwan/fzf-lua',
    name = 'fzf-lua',
    cmd = 'FzfLua',
    keys = {
      { '<leader>ff', fzf_call 'files', desc = 'FzfLua find files' },
      { '<leader>fg', fzf_call 'live_grep', desc = 'FzfLua live grep' },
      { '<leader>fb', fzf_call 'buffers', desc = 'FzfLua buffers' },
      { '<leader>ft', fzf_call 'tabs', desc = 'FzfLua tabs' },
      { '<leader>fh', fzf_call 'help_tags', desc = 'FzfLua help tags' },
      { '<leader>fk', fzf_call 'keymaps', desc = 'FzfLua keymaps' },
      { '<leader>fo', fzf_call 'oldfiles', desc = 'FzfLua old files' },
      { '<leader>gf', fzf_call 'git_files', desc = 'FzfLua git files' },
      { '<leader>gs', fzf_call 'git_status', desc = 'FzfLua git status' },
      { '<leader>gS', fzf_call 'git_stash', desc = 'FzfLua git stash' },
      { '<leader>gb', fzf_call 'git_branches', desc = 'FzfLua git branches' },
      { '<leader>gc', fzf_call 'git_commits', desc = 'FzfLua git commits' },
      { 'gO', fzf_call 'lsp_document_symbols', desc = 'FzfLua LSP document symbols' },
      { 'gW', fzf_call 'lsp_workspace_symbols', desc = 'FzfLua LSP workspace symbols' },
      { 'gra', fzf_call 'lsp_code_actions', desc = 'FzfLua LSP code actions' },
      { 'gri', fzf_call 'lsp_implementations', desc = 'FzfLua LSP implementations' },
      { 'grr', fzf_call 'lsp_references', desc = 'FzfLua LSP references' },
      { 'grt', fzf_call 'lsp_typedefs', desc = 'FzfLua LSP typedefs' },
      { 'grd', fzf_call 'lsp_definitions', desc = 'FzfLua LSP definitions' },
      { 'grq', fzf_call 'diagnostics_document', desc = 'FzfLua document diagnostics' },
      { 'grQ', fzf_call 'diagnostics_workspace', desc = 'FzfLua workspace diagnostics' },
    },
  },
  {
    url = gh 'folke/flash.nvim',
    name = 'flash.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>j',
        function()
          require('flash').jump()
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash',
      },
      {
        '<leader>J',
        function()
          require('flash').treesitter()
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash Treesitter',
      },
    },
    opts = {},
  },
}
