return {
  'romus204/tree-sitter-manager.nvim',
  opts = {
    highlight = true,
  },
  config = function(_, opts)
    require('tree-sitter-manager').setup()
    -- This is a temporary solution, pending an upstream fix in tree-sitter-manager.
    pcall(vim.treesitter.start)
  end,
  event = 'VeryLazy',
}
