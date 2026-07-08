local gh = require('modules.plugin-util').gh

return {
  {
    url = gh 'neovim/nvim-lspconfig',
    name = 'nvim-lspconfig',
    lazy = false,
  },
  {
    url = gh 'mason-org/mason.nvim',
    name = 'mason.nvim',
    lazy = false,
    cmd = 'Mason',
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    opts = {},
  },
  {
    url = gh 'j-hui/fidget.nvim',
    name = 'fidget.nvim',
    event = 'LspAttach',
    init = function()
      vim.api.nvim_clear_autocmds {
        group = 'UserLspProgressNotify',
      }
    end,
    opts = {},
  },
  {
    url = gh 'saghen/blink.cmp',
    name = 'blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    cmd = 'BlinkCmp',
    dependencies = {
      {
        url = gh 'rafamadriz/friendly-snippets',
        name = 'friendly-snippets',
      },
    },
    init = function()
      vim.opt.autocomplete = false
      vim.opt.complete:remove 'o'
      vim.api.nvim_clear_autocmds {
        group = 'UserLspCompletion',
      }
      for _, client in ipairs(vim.lsp.get_clients()) do
        for bufnr, _ in pairs(client.attached_buffers or {}) do
          pcall(vim.lsp.completion.enable, false, client.id, bufnr)
        end
      end
    end,
    opts = {
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    },
  },
  {
    url = gh 'rachartier/tiny-inline-diagnostic.nvim',
    name = 'tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    init = function()
      vim.diagnostic.config { virtual_text = false }
    end,
    opts = {
      options = {
        multilines = {
          enabled = true,
        },
      },
    },
  },
}
