local map = vim.keymap.set

-- LSP & Treesitter: run immediately when opening files from CLI, otherwise defer
local function setup_lsp_and_ts()
  vim.cmd.packadd 'nvim-lspconfig'
  vim.cmd.packadd 'mason.nvim'
  vim.cmd.packadd 'mason-lspconfig.nvim'
  vim.cmd.packadd 'tree-sitter-manager.nvim'

  require('mason').setup {}
  map('n', '<leader>tm', '<cmd>Mason<cr>', { desc = 'Mason' })

  local mason_lspconfig = require 'mason-lspconfig'
  local managed = mason_lspconfig.get_mappings().lspconfig_to_package
  local ensure_installed, exclude, unmanaged = {}, {}, {}

  for name, enabled in pairs(UserConfig.lsp) do
    if managed[name] then
      table.insert(enabled and ensure_installed or exclude, name)
    else
      unmanaged[name] = enabled
    end
  end

  mason_lspconfig.setup {
    ensure_installed = ensure_installed,
    automatic_enable = { exclude = exclude },
  }

  for name, enabled in pairs(unmanaged) do
    vim.lsp.enable(name, enabled)
  end

  require('tree-sitter-manager').setup(vim.deepcopy(UserConfig.treesitter))
  map('n', '<leader>ts', '<cmd>TSManager<cr>', { desc = 'Treesitter manager' })
end

if vim.fn.argc(-1) > 0 then
  setup_lsp_and_ts()
else
  vim.schedule(setup_lsp_and_ts)
end

-- blink.cmp + friendly-snippets (on InsertEnter / CmdlineEnter)
vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  once = true,
  callback = function()
    vim.cmd.packadd 'friendly-snippets'
    vim.cmd.packadd 'blink.cmp'
    require('blink.cmp').setup {
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    }
  end,
})
