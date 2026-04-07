local M = {}

local builtin = require 'telescope.builtin'
local augroup = require('user.lib.augroup').create

local function basic_keymaps()
  vim.keymap.set('n', '<leader>fs', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>fz', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
  vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Telescope git_files' })
  vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old_files' })
end

local function lsp_buf_setup(event)
  local bufnr = event.buf
  vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = bufnr, desc = 'Telescope LSP References' })
  vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = bufnr, desc = 'Telescope LSP Implementations' })
  vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = bufnr, desc = 'Telescope LSP Definitions' })
  vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = bufnr, desc = 'Telescope LSP Document Symbols' })
  vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = 'Telescope LSP Workspace Symbols' })
  vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = bufnr, desc = 'Telescope LSP Type Definitions' })
end

function M.setup()
  require('telescope').load_extension 'fzf'
  basic_keymaps()

  vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup 'UserLspAttach',
    callback = lsp_buf_setup,
  })
end

return M
