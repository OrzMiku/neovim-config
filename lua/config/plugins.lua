-- [[ PackChanged/PackChangedPre Handlers ]]
local pack_changed_group = vim.api.nvim_create_augroup('UserPackChanged', { clear = true })
vim.api.nvim_create_autocmd('PackChanged', {
  group = pack_changed_group,
  callback = function(event)
    vim.notify(vim.inspect(event.data))
    local name, kind, active = event.data.spec.name, event.data.kind, event.data.active
    if name == 'markdown-preview.nvim' and (kind == 'install' or kind == 'update') then
      if not active then
        vim.cmd.packadd 'markdown-preview.nvim'
      end
      vim.fn['mkdp#util#install']()
    end
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- [[ Plugin Declarations ]]
-- Helper Functions
---@diagnostic disable-next-line: unused-function
local gh = function(repo)
  return 'https://github.com/' .. repo
end
---@diagnostic disable-next-line: unused-local, unused-function
local cb = function(repo)
  return 'https://codeberg.org/' .. repo
end

if vim.g.have_nerd_font then
  -- Icons
  vim.pack.add {
    {
      src = gh 'nvim-tree/nvim-web-devicons',
      version = vim.version.range '0',
    },
  }
end

vim.pack.add {
  -- [[ UI & Appearance ]]
  -- Colorschemes
  gh 'folke/tokyonight.nvim',
  {
    src = gh 'catppuccin/nvim',
    name = 'catppuccin',
  },
  -- Statusline
  gh 'echasnovski/mini.nvim',
  -- File explorer
  gh 'nvim-tree/nvim-tree.lua',
  -- Buffer tabs
  gh 'akinsho/bufferline.nvim',
  -- Indent guides
  gh 'lukas-reineke/indent-blankline.nvim',

  -- [[ Search & Navigation ]]
  -- Fuzzy finder
  gh 'nvim-lua/plenary.nvim',
  {
    src = gh 'nvim-telescope/telescope.nvim',
    version = vim.version.range '^0.2.0',
  },

  -- [[ Editing & Code Intelligence ]]
  -- Completion
  {
    src = gh 'saghen/blink.cmp',
    version = vim.version.range '1',
  },
  -- Snippets
  gh 'rafamadriz/friendly-snippets',
  -- Syntax highlighting
  gh 'nvim-treesitter/nvim-treesitter',
  -- Comment toggling
  gh 'numToStr/Comment.nvim',

  -- [[ LSP & Development Tools ]]
  -- LSP configuration
  gh 'neovim/nvim-lspconfig',
  gh 'folke/lazydev.nvim',
  -- LSP package manager
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  -- LSP UI enhancements
  gh 'j-hui/fidget.nvim',
  -- Code formatter
  gh 'stevearc/conform.nvim',
  -- Markdown Preview
  gh 'iamcco/markdown-preview.nvim',
  gh 'MeanderingProgrammer/render-markdown.nvim',

  -- [[ Git Integration ]]
  gh 'lewis6991/gitsigns.nvim',

  -- [[ Utilities ]]
  -- Key binding helper
  gh 'folke/which-key.nvim',
}

-- [[ Plugin Configurations ]]

-- [[ UI & Appearance ]]

-- Colorscheme
vim.cmd.colorscheme 'catppuccin-macchiato'

-- Statusline
require('mini.statusline').setup {}

-- File explorer
require('nvim-tree').setup {}
vim.keymap.set('', '<leader>e', ':NvimTreeFindFileToggle<cr>', { desc = 'Toggle file explorer' })

-- Buffer tabs
require('bufferline').setup {}

-- Indent guides
require('ibl').setup {}

-- [[ Search & Navigation ]]

-- Fuzzy finder keymaps
vim.keymap.set('n', '<leader>fs', ':Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fp', ':Telescope git_files<cr>', { desc = 'Find git files' })
vim.keymap.set('n', '<leader>fz', ':Telescope live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<cr>', { desc = 'Find recent files' })
vim.keymap.set('n', '<leader>fk', ':Telescope keymaps<CR>', { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>', { desc = 'Find help documentation' })
vim.keymap.set('n', '<leader>f?', ':Telescope help_tags<cr>', { desc = 'Find help documentation' })

-- [[ Editing & Code Intelligence ]]

-- Completion
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

-- Treesitter
require('nvim-treesitter').setup {}

-- Comment toggling
require('Comment').setup()

-- [[ LSP & Development Tools ]]

-- LSP configuration
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- LSP UI enhancements
require('fidget').setup {}

-- LSP package manager
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

-- LSP keymaps (set on buffer attach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
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
})

-- Diagnostic configuration
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
}

-- Code formatter
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
end, { desc = 'Format buffer' })

-- [[ Git Integration ]]

require('gitsigns').setup()

-- [[ Utilities ]]

-- Key binding helper
require('which-key').setup()
vim.keymap.set('n', '<leader>?', ':WhichKey<cr>', { desc = 'Show all keymaps' })
