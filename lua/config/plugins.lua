---@diagnostic disable-next-line: unused-function
local gh = function(x)
  return 'https://github.com/' .. x
end
---@diagnostic disable-next-line: unused-local, unused-function
local cb = function(x)
  return 'https://codeberg.org/' .. x
end

vim.pack.add {
  -- colorschemes
  gh 'folke/tokyonight.nvim',
  {
    src = gh 'catppuccin/nvim',
    name = 'catppuccin.nvim',
  },
  -- icons
  vim.g.have_nerd_font and gh 'nvim-tree/nvim-web-devicons' or nil,
  -- fuzzy search
  gh 'nvim-lua/plenary.nvim',
  {
    src = gh 'nvim-telescope/telescope.nvim',
    version = vim.version.range '^0.2.0',
  },
  -- completion
  {
    src = gh 'saghen/blink.cmp',
    version = vim.version.range '1',
  },
  -- lsp
  gh 'neovim/nvim-lspconfig',
  gh 'folke/lazydev.nvim',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',
  -- formatter
  gh 'stevearc/conform.nvim',
}

-- colorschemes
vim.cmd.colorscheme 'catppuccin-macchiato'

-- fuzzy search
vim.keymap.set('n', '<leader>fs', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fp', ':Telescope git_files<cr>')
vim.keymap.set('n', '<leader>fz', ':Telescope live_files<cr>')
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<cr>')

-- completion
require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}

-- lsp
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

require('fidget').setup {}
require('mason').setup {
  ui = { border = 'rounded' },
}

local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

require('mason-lspconfig').setup {
  ensure_installed = {
    'lua_ls',
    'jsonls',
    'taplo',
    'yamlls',
    'ts_ls',
    'html',
    'cssls',
    'clangd',
    'marksman',
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
    end,
  },
}

require('mason-tool-installer').setup {
  ensure_installed = {
    'prettier',
    'stylua',
    'markdownlint',
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
  end,

  vim.diagnostic.config {
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = true,
  },
})

-- formatter
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    toml = { 'prettier' },
    markdown = { 'prettier', 'markdownlint' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
  },
}

vim.keymap.set('', '<leader>ff', function()
  require('conform').format {
    async = true,
    lsp_format = 'fallback',
  }
end)
