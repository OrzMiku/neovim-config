--------------------------------------------------------------------------------
--- 10-plugins
--------------------------------------------------------------------------------

local use = Config.plugin_enabled
local use_feature = Config.plugin_feature_enabled

if not Config.enable_plugins then
  return
end

local gh = Config.github_url
local map = vim.keymap.set

--------------------------------------------------------------------------------
--- Colors
--------------------------------------------------------------------------------

-- catppuccin
if use 'catppuccin' then
  vim.pack.add {
    {
      src = gh 'catppuccin/nvim',
      name = 'catppuccin',
    },
  }
  vim.cmd.colorscheme 'catppuccin-nvim'
end

--------------------------------------------------------------------------------
--- Editor
--------------------------------------------------------------------------------

-- mini.nvim
if use 'mini' then
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  if use_feature('mini', 'icons') then
    require('mini.icons').setup {
      style = Config.have_nerd_font and 'glyph' or 'ascii',
    }
    MiniIcons.mock_nvim_web_devicons()
  end

  if use_feature('mini', 'ai') then
    local ai = require 'mini.ai'
    ai.setup {
      custom_textobjects = {
        B = require('mini.extra').gen_ai_spec.buffer(),
        F = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
      },
    }
  end

  if use_feature('mini', 'surround') then
    require('mini.surround').setup()
  end

  if use_feature('mini', 'statusline') then
    require('mini.statusline').setup()
  end

  if use_feature('mini', 'indentscope') then
    require('mini.indentscope').setup {}
  end

  if use_feature('mini', 'pairs') then
    require('mini.pairs').setup {
      modes = { command = true },
    }
  end

  if use_feature('mini', 'move') then
    require('mini.move').setup()
  end
end

-- oil.nvim
if use 'oil' then
  vim.pack.add { gh 'stevearc/oil.nvim' }
  require('oil').setup()
  map('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
end

-- bufferline.nvim
if use 'bufferline' then
  vim.pack.add { gh 'akinsho/bufferline.nvim' }
  require('bufferline').setup {
    highlights = use 'catppuccin' and require('catppuccin.special.bufferline').get_theme() or nil,
  }
  map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
  map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
  map('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer left' })
  map('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer right' })
  map('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle buffer pin' })
  map('n', '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', { desc = 'Delete non-pinned buffers' })
  map('n', '<leader>br', '<cmd>BufferLineCloseRight<cr>', { desc = 'Delete buffers right' })
  map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Delete buffers left' })
  map('n', '<leader>bj', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer' })
end

-- dropbar.nvim
if use 'dropbar' then
  vim.pack.add { gh 'Bekaboo/dropbar.nvim' }
  require('dropbar').setup()
  map('n', '<leader>;', require('dropbar.api').pick, { desc = 'Pick winbar symbols' })
  map('n', '[;', require('dropbar.api').goto_context_start, { desc = 'Go to context start' })
  map('n', '];', require('dropbar.api').select_next_context, { desc = 'Select next context' })
end

-- which-key.nvim
if use 'which_key' then
  vim.pack.add { gh 'folke/which-key.nvim' }
  local which_key = require 'which-key'
  which_key.setup {
    spec = {
      { '<leader>b', group = 'buffer' },
      { '<leader>c', group = 'code', mode = { 'n', 'x' } },
      { '<leader>f', group = 'find' },
      { '<leader>g', group = 'git', mode = { 'n', 'x' } },
      { '<leader>gh', group = 'hunks', mode = { 'n', 'x' } },
      { '<leader>s', group = 'search', mode = { 'n', 'x' } },
      { '<leader>x', group = 'diagnostics/quickfix' },
      { '[', group = 'previous' },
      { ']', group = 'next' },
      { 'g', group = 'goto' },
    },
  }
  map('n', '<leader>?', function()
    which_key.show { global = false }
  end, { desc = 'Buffer Local Keymaps' })
end

--------------------------------------------------------------------------------
--- Treesitter and LSP
--------------------------------------------------------------------------------

-- tree-sitter-manager.nvim
if use 'tree_sitter_manager' then
  vim.pack.add { gh 'romus204/tree-sitter-manager.nvim' }
  require('tree-sitter-manager').setup()
end

-- nvim-lspconfig
if use 'lspconfig' then
  vim.pack.add { gh 'neovim/nvim-lspconfig' }
end

-- mason.nvim
if use 'mason' then
  vim.pack.add { gh 'mason-org/mason.nvim' }
  require('mason').setup()
  map('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Mason' })
end

-- lazydev.nvim
if use 'lazydev' then
  vim.pack.add { gh 'folke/lazydev.nvim' }
  require('lazydev').setup {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }
end

-- fidget.nvim
if use 'fidget' then
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}
end

-- blink.cmp
if use 'blink_cmp' then
  vim.pack.add {
    gh 'rafamadriz/friendly-snippets',
    {
      src = gh 'saghen/blink.cmp',
      version = vim.version.range '1.*',
    },
  }
  require('blink.cmp').setup {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  }
end

-- tiny-inline-diagnostic.nvim
if use 'tiny_inline_diagnostic' then
  vim.pack.add { gh 'rachartier/tiny-inline-diagnostic.nvim' }
  require('tiny-inline-diagnostic').setup {
    options = {
      multilines = {
        enabled = true,
      },
    },
  }
end

--------------------------------------------------------------------------------
--- Find and Jump
--------------------------------------------------------------------------------

-- fzf-lua
if use 'fzf_lua' then
  vim.pack.add { gh 'ibhagwan/fzf-lua' }
  local fzf = require 'fzf-lua'
  fzf.setup {
    winopts = {
      zindex = 100,
    },
  }

  local function fzf_call(method)
    return function()
      fzf[method]()
    end
  end

  map('n', '<leader>ff', fzf_call 'files', { desc = 'Find files' })
  map('n', '<leader>fg', fzf_call 'live_grep', { desc = 'Live grep' })
  map('n', '<leader>fb', fzf_call 'buffers', { desc = 'Find buffers' })
  map('n', '<leader>ft', fzf_call 'tabs', { desc = 'Find tabs' })
  map('n', '<leader>fh', fzf_call 'help_tags', { desc = 'Find help' })
  map('n', '<leader>fk', fzf_call 'keymaps', { desc = 'Find keymaps' })
  map('n', '<leader>fo', fzf_call 'oldfiles', { desc = 'Find old files' })
  map('n', '<leader>gf', fzf_call 'git_files', { desc = 'Git files' })
  map('n', '<leader>gs', fzf_call 'git_status', { desc = 'Git status' })
  map('n', '<leader>gS', fzf_call 'git_stash', { desc = 'Git stash' })
  map('n', '<leader>gb', fzf_call 'git_branches', { desc = 'Git branches' })
  map('n', '<leader>gc', fzf_call 'git_commits', { desc = 'Git commits' })
  map('n', 'gO', fzf_call 'lsp_document_symbols', { desc = 'Document symbols' })
  map('n', 'gW', fzf_call 'lsp_workspace_symbols', { desc = 'Workspace symbols' })
  map({ 'n', 'x' }, 'gra', fzf_call 'lsp_code_actions', { desc = 'Code actions' })
  map('n', 'gri', fzf_call 'lsp_implementations', { desc = 'Implementations' })
  map('n', 'grr', fzf_call 'lsp_references', { desc = 'References' })
  map('n', 'grt', fzf_call 'lsp_typedefs', { desc = 'Type definitions' })
  map('n', 'gd', fzf_call 'lsp_definitions', { desc = 'Definitions' })
  map('n', 'grq', fzf_call 'diagnostics_document', { desc = 'Document diagnostics' })
  map('n', 'grQ', fzf_call 'diagnostics_workspace', { desc = 'Workspace diagnostics' })
end

-- flash.nvim
if use 'flash' then
  vim.pack.add { gh 'folke/flash.nvim' }
  local flash = require 'flash'
  flash.setup()
  map({ 'n', 'x', 'o' }, '<leader>j', flash.jump, { desc = 'Flash' })
  map({ 'n', 'x', 'o' }, '<leader>J', flash.treesitter, { desc = 'Flash Treesitter' })
end

--------------------------------------------------------------------------------
--- Git
--------------------------------------------------------------------------------

-- gitsigns.nvim
if use 'gitsigns' then
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local function buffer_map(mode, lhs, rhs, desc)
        map(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
      end

      buffer_map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, 'Next hunk')
      buffer_map('n', ']H', function()
        gitsigns.nav_hunk 'last'
      end, 'Last hunk')
      buffer_map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, 'Previous hunk')
      buffer_map('n', '[H', function()
        gitsigns.nav_hunk 'first'
      end, 'First hunk')

      buffer_map('n', '<leader>ghs', gitsigns.stage_hunk, 'Stage hunk')
      buffer_map('x', '<leader>ghs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Stage hunk')
      buffer_map('n', '<leader>ghr', gitsigns.reset_hunk, 'Reset hunk')
      buffer_map('x', '<leader>ghr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'Reset hunk')
      buffer_map('n', '<leader>ghS', gitsigns.stage_buffer, 'Stage buffer')
      buffer_map('n', '<leader>ghR', gitsigns.reset_buffer, 'Reset buffer')
      buffer_map('n', '<leader>ghp', gitsigns.preview_hunk_inline, 'Preview hunk')
      buffer_map('n', '<leader>ghb', function()
        gitsigns.blame_line { full = true }
      end, 'Blame line')
      buffer_map('n', '<leader>ghB', gitsigns.blame, 'Blame buffer')
      buffer_map('n', '<leader>ghd', gitsigns.diffthis, 'Diff this')
      buffer_map('n', '<leader>ghD', function()
        gitsigns.diffthis '~'
      end, 'Diff this ~')
      buffer_map('n', '<leader>ght', gitsigns.toggle_current_line_blame, 'Toggle line blame')
      buffer_map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
    end,
  }
end

-- neogit
if use 'neogit' then
  vim.pack.add {
    gh 'nvim-lua/plenary.nvim',
    {
      src = gh 'dlyongemallo/diffview-plus.nvim',
      name = 'diffview-plus.nvim',
    },
    gh 'NeogitOrg/neogit',
  }
  map('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Show Neogit UI' })
end

--------------------------------------------------------------------------------
--- Tools
--------------------------------------------------------------------------------

-- conform.nvim
if use 'conform' then
  vim.pack.add { gh 'stevearc/conform.nvim' }
  local conform = require 'conform'
  conform.setup {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      nix = { 'nixfmt' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      fish = { 'fish_indent' },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      yml = { 'prettierd', 'prettier', stop_after_first = true },
      toml = { 'taplo' },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      ['markdown.mdx'] = { 'prettierd', 'prettier', stop_after_first = true },
      mdx = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      less = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      vue = { 'prettierd', 'prettier', stop_after_first = true },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      objc = { 'clang-format' },
      objcpp = { 'clang-format' },
      cuda = { 'clang-format' },
      rust = { 'rustfmt' },
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
      xml = { 'xmlformatter' },
    },
  }
  map({ 'n', 'x' }, '<leader>cf', function()
    conform.format {}
  end, { desc = 'Code format' })
end

-- nvim-bqf
if use 'bqf' then
  vim.pack.add { gh 'kevinhwang91/nvim-bqf' }
  require('bqf').setup()
end

-- quicker.nvim
if use 'quicker' then
  vim.pack.add { gh 'stevearc/quicker.nvim' }
  local quicker = require 'quicker'
  quicker.setup {
    keys = {
      {
        '>',
        function()
          quicker.expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        quicker.collapse,
        desc = 'Collapse quickfix context',
      },
    },
  }
  map('n', '<leader>xq', function()
    quicker.toggle { focus = true }
  end, { desc = 'Toggle quickfix' })
  map('n', '<leader>xl', function()
    quicker.toggle { focus = true, loclist = true }
  end, { desc = 'Toggle location list' })
end

-- render-markdown.nvim
if use 'render_markdown' then
  vim.pack.add { gh 'MeanderingProgrammer/render-markdown.nvim' }
end

-- live-preview
if use 'live_preview' then
  vim.pack.add { gh 'brianhuster/live-preview.nvim' }
end

-- grug-far.nvim
if use 'grug_far' then
  vim.pack.add { gh 'MagicDuck/grug-far.nvim' }
  map({ 'n', 'x' }, '<leader>sr', function()
    local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
    require('grug-far').open {
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
      },
    }
  end, { desc = 'Search and replace' })
end
