--------------------------------------------------------------------------------
--- 10-plugins (lazy.nvim)
--------------------------------------------------------------------------------

local use = Config.plugin_enabled
local use_feature = Config.plugin_feature_enabled

local gh = Config.github_url
local map = vim.keymap.set

local spec = {
  --------------------------------------------------------------------------------
  --- Colors
  --------------------------------------------------------------------------------

  -- catppuccin
  {
    url = gh 'catppuccin/nvim',
    commit = 'edefef779ab08ce1a4a404713e3012b0d202bd35',
    priority = 1000,
    lazy = false,
    enabled = use 'catppuccin',
    config = function()
      vim.cmd.colorscheme 'catppuccin-nvim'
    end,
  },

  --------------------------------------------------------------------------------
  --- Editor
  --------------------------------------------------------------------------------

  -- mini.nvim
  {
    url = gh 'nvim-mini/mini.nvim',
    commit = '9d01f392b33fb2ba36fbc87fc0bf4453e63ffb0a',
    event = { 'VeryLazy' },
    enabled = use 'mini',
    config = function()
      if use_feature('mini', 'icons') then
        require('mini.icons').setup {
          style = Config.have_nerd_font and 'glyph' or 'ascii',
        }
        MiniIcons.mock_nvim_web_devicons()
      end

      if use_feature('mini', 'ai') then
        require('mini.ai').setup {
          custom_textobjects = {
            B = require('mini.extra').gen_ai_spec.buffer(),
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
    end,
  },

  -- oil.nvim：vim . 不开油不开 netrw（rtp 已禁 netrw），按 - / :Oil 才进
  {
    url = gh 'stevearc/oil.nvim',
    commit = 'b73018b75affd13fa38e2fc94ef753b465f770d7',
    cmd = { 'Oil' },
    keys = { '-' },
    enabled = use 'oil',
    config = function()
      require('oil').setup()
      map('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
    end,
  },

  -- bufferline.nvim
  {
    url = gh 'akinsho/bufferline.nvim',
    commit = '655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3',
    event = { 'VeryLazy' },
    enabled = use 'bufferline',
    config = function()
      require('bufferline').setup {
        highlights = use 'catppuccin' and require('catppuccin.special.bufferline').get_theme() or nil,
        options = {
          always_show_bufferline = false,
        },
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
    end,
  },

  -- dropbar.nvim
  {
    url = gh 'Bekaboo/dropbar.nvim',
    commit = '808ba31cde89aec8833e9789f5e04557cd31c9e1',
    event = { 'VeryLazy' },
    enabled = use 'dropbar',
    config = function()
      require('dropbar').setup()
      map('n', '<leader>ns', require('dropbar.api').pick, { desc = 'Pick winbar symbols' })
      map('n', '[;', require('dropbar.api').goto_context_start, { desc = 'Go to context start' })
      map('n', '];', require('dropbar.api').select_next_context, { desc = 'Select next context' })
    end,
  },

  -- which-key.nvim
  {
    url = gh 'folke/which-key.nvim',
    commit = '3aab2147e74890957785941f0c1ad87d0a44c15a',
    event = { 'VeryLazy' },
    enabled = use 'which_key',
    config = function()
      local which_key = require 'which-key'
      which_key.setup {
        spec = {
          { '<leader>b', group = 'buffer', icon = { icon = '󰈔', color = 'cyan' } },
          { '<leader>c', group = 'code', icon = { icon = '', color = 'orange' }, mode = { 'n', 'x' } },
          { '<leader>f', group = 'find', icon = { icon = '', color = 'green' } },
          { '<leader>g', group = 'git', icon = { icon = '', color = 'orange' }, mode = { 'n', 'x' } },
          { '<leader>s', group = 'search', icon = { icon = '', color = 'green' }, mode = { 'n', 'x' } },
          { '<leader>x', group = 'lists', icon = { icon = '', color = 'yellow' } },
          { '<leader>n', group = 'navigation', icon = { icon = '', color = 'blue' }, mode = { 'n', 'x', 'o' } },
          { '<leader>t', group = 'tools', icon = { icon = '', color = 'purple' } },
          { '<leader>h', group = 'help', icon = { icon = '󰋖', color = 'cyan' } },
          { '<leader>y', icon = { icon = '', color = 'yellow' }, mode = { 'n', 'x' } },
          { '<leader>p', icon = { icon = '', color = 'green' }, mode = { 'n', 'x' } },
          { '[', group = 'previous', icon = { icon = '', color = 'blue' } },
          { ']', group = 'next', icon = { icon = '', color = 'blue' } },
          { 'g', group = 'goto', icon = { icon = '', color = 'blue' } },
        },
      }
      map('n', '<leader>hk', function()
        which_key.show { global = false }
      end, { desc = 'Buffer Local Keymaps' })
    end,
  },

  --------------------------------------------------------------------------------
  --- Treesitter and LSP
  --------------------------------------------------------------------------------

  -- tree-sitter-manager.nvim
  {
    url = gh 'romus204/tree-sitter-manager.nvim',
    commit = '023590c8f068788a0513a4409bf37ff7f9d1deff',
    event = { 'VeryLazy' },
    enabled = use 'tree_sitter_manager',
    config = function()
      require('tree-sitter-manager').setup {
        highlight = false,
        -- Install languages on demand with :TSInstall (see README).
        auto_install = false,
      }
      map('n', '<leader>ts', '<cmd>TSManager<cr>', { desc = 'Treesitter manager' })
    end,
  },

  -- nvim-lspconfig：20-lsp.lua 启动期原生 vim.lsp.enable 依赖其注册
  {
    url = gh 'neovim/nvim-lspconfig',
    commit = '84252f9832fb5b9024fe9f7258e7c2aff915e6fb',
    lazy = false,
    enabled = use 'lspconfig',
  },

  -- mason.nvim
  {
    url = gh 'mason-org/mason.nvim',
    commit = '2a6940af80375532e5e9e7c1f2fc6319a1b7a69d',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    keys = { '<leader>tm' },
    enabled = use 'mason',
    config = function()
      require('mason').setup()
      map('n', '<leader>tm', '<cmd>Mason<cr>', { desc = 'Mason' })
    end,
  },

  -- blink.cmp
  {
    url = gh 'saghen/blink.cmp',
    commit = '78336bc89ee5365633bcf754d93df01678b5c08f',
    event = { 'InsertEnter' },
    enabled = use 'blink_cmp',
    dependencies = {
      {
        url = gh 'rafamadriz/friendly-snippets',
        commit = '6cd7280adead7f586db6fccbd15d2cac7e2188b9',
        enabled = use 'blink_cmp',
      },
      {
        url = gh 'folke/lazydev.nvim',
        commit = 'ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d',
        enabled = use 'lazydev',
        config = function()
          require('lazydev').setup {
            library = {
              { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
          }
        end,
      },
    },
    config = function()
      require('blink.cmp').setup {
        sources = use 'lazydev' and {
          per_filetype = {
            lua = { inherit_defaults = true, 'lazydev' },
          },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
          },
        } or nil,
        completion = {
          list = {
            selection = {
              preselect = false,
            },
          },
        },
      }
    end,
  },

  -- fidget.nvim
  {
    url = gh 'j-hui/fidget.nvim',
    commit = '9e0201673e08e997e7cf52afca5565c70bd117f3',
    event = { 'VeryLazy' },
    enabled = use 'fidget',
    config = function()
      require('fidget').setup {}
    end,
  },

  -- tiny-inline-diagnostic.nvim
  {
    url = gh 'rachartier/tiny-inline-diagnostic.nvim',
    commit = '6264451f14119d63a52580e5198d6baf8518b0b2',
    event = { 'VeryLazy' },
    enabled = use 'tiny_inline_diagnostic',
    config = function()
      require('tiny-inline-diagnostic').setup {
        options = {
          multilines = {
            enabled = true,
          },
        },
      }
    end,
  },

  --------------------------------------------------------------------------------
  --- Find and Jump
  --------------------------------------------------------------------------------

  -- fzf-lua
  {
    url = gh 'ibhagwan/fzf-lua',
    commit = '05e44d38de0a79c11fba5f7bf8138791b1dbdd1e',
    keys = {
      '<leader>ff', '<leader>sg', '<leader>hh', '<leader>fr', '<leader>f?', '<leader>sb',
      'gO', 'gW',
      { 'gra', mode = { 'n', 'x' } },
      'gri', 'grr', 'grt', 'gd', 'gD',
      '<leader>xd', '<leader>xD',
    },
    enabled = use 'fzf_lua',
    config = function()
      local fzf = require 'fzf-lua'
      fzf.setup {
        fzf_colors = true,
        ui_select = {},
      }

      map('n', '<leader>ff', fzf.global, { desc = 'Find files, buffers and symbols' })
      map('n', '<leader>sg', fzf.live_grep, { desc = 'Live grep' })
      map('n', '<leader>hh', fzf.helptags, { desc = 'Find help' })
      map('n', '<leader>fr', fzf.resume, { desc = 'Resume last picker' })
      map('n', '<leader>f?', fzf.builtin, { desc = 'Find pickers' })
      map('n', '<leader>sb', fzf.blines, { desc = 'Lines in buffer' })

      map('n', 'gO', fzf.lsp_document_symbols, { desc = 'Document symbols' })
      map('n', 'gW', fzf.lsp_workspace_symbols, { desc = 'Workspace symbols' })
      map({ 'n', 'x' }, 'gra', fzf.lsp_code_actions, { desc = 'Code actions' })
      map('n', 'gri', fzf.lsp_implementations, { desc = 'Implementations' })
      map('n', 'grr', fzf.lsp_references, { desc = 'References' })
      map('n', 'grt', fzf.lsp_typedefs, { desc = 'Type definitions' })
      map('n', 'gd', fzf.lsp_definitions, { desc = 'Definitions' })
      map('n', 'gD', fzf.lsp_declarations, { desc = 'Declarations' })
      map('n', '<leader>xd', fzf.diagnostics_document, { desc = 'Document diagnostics' })
      map('n', '<leader>xD', fzf.diagnostics_workspace, { desc = 'Workspace diagnostics' })
    end,
  },

  -- flash.nvim
  {
    url = gh 'folke/flash.nvim',
    commit = '5f0f270fdc7c5b0c21d903ee85b9cb06f2ac636a',
    event = { 'VeryLazy' },
    enabled = use 'flash',
    config = function()
      local flash = require 'flash'
      flash.setup()
      map({ 'n', 'x', 'o' }, '<leader>nj', flash.jump, { desc = 'Flash' })
      map({ 'n', 'x', 'o' }, '<leader>nt', flash.treesitter, { desc = 'Flash Treesitter' })
    end,
  },

  --------------------------------------------------------------------------------
  --- Git
  --------------------------------------------------------------------------------

  -- gitsigns.nvim
  {
    url = gh 'lewis6991/gitsigns.nvim',
    commit = '5be654f2232c10ddcad19c1607a67b6b4b78fc29',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = use 'gitsigns',
    config = function()
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

          buffer_map('n', '<leader>gs', gitsigns.stage_hunk, 'Stage hunk')
          buffer_map('x', '<leader>gs', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, 'Stage hunk')
          buffer_map('n', '<leader>gr', gitsigns.reset_hunk, 'Reset hunk')
          buffer_map('x', '<leader>gr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, 'Reset hunk')
          buffer_map('n', '<leader>gS', gitsigns.stage_buffer, 'Stage buffer')
          buffer_map('n', '<leader>gR', gitsigns.reset_buffer, 'Reset buffer')
          buffer_map('n', '<leader>gp', gitsigns.preview_hunk_inline, 'Preview hunk')
          buffer_map('n', '<leader>gb', function()
            gitsigns.blame_line { full = true }
          end, 'Blame line')
          buffer_map('n', '<leader>gB', gitsigns.blame, 'Blame buffer')
          buffer_map('n', '<leader>gd', gitsigns.diffthis, 'Diff this')
          buffer_map('n', '<leader>gD', function()
            gitsigns.diffthis '~'
          end, 'Diff this ~')
          buffer_map('n', '<leader>gt', gitsigns.toggle_current_line_blame, 'Toggle line blame')
          buffer_map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
        end,
      }
    end,
  },

  -- neogit
  {
    url = gh 'NeogitOrg/neogit',
    commit = '5adc81b26232954cd7a90f158aa7844c18fc3165',
    cmd = { 'Neogit' },
    keys = { '<leader>gg' },
    enabled = use 'neogit',
    dependencies = {
      {
        url = gh 'nvim-lua/plenary.nvim',
        commit = '74b06c6c75e4eeb3108ec01852001636d85a932b',
      },
      {
        url = gh 'dlyongemallo/diffview-plus.nvim',
        commit = '43e60bca414e4991ed10118e59f809fb03bbeddd',
      },
    },
    config = function()
      map('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Show Neogit UI' })
    end,
  },

  --------------------------------------------------------------------------------
  --- Tools
  --------------------------------------------------------------------------------

  -- conform.nvim
  {
    url = gh 'stevearc/conform.nvim',
    commit = '016802de402556da54c36bd7359b441266b01cdd',
    keys = { { '<leader>cf', mode = { 'n', 'x' } } },
    enabled = use 'conform',
    config = function()
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
          toml = { 'taplo' },
          markdown = { 'prettierd', 'prettier', stop_after_first = true },
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
    end,
  },

  -- nvim-bqf
  {
    url = gh 'kevinhwang91/nvim-bqf',
    commit = 'c282a62bec6c0621a1ef5132aa3f4c9fc4dcc2c7',
    enabled = use 'bqf',
    config = function()
      require('bqf').setup()
    end,
  },

  -- quicker.nvim
  {
    url = gh 'stevearc/quicker.nvim',
    commit = '4a6883cb13fe097a20a046eb55f6dffd239276e3',
    keys = { '<leader>xq', '<leader>xl' },
    enabled = use 'quicker',
    dependencies = { 'nvim-bqf' },
    config = function()
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
    end,
  },

  -- render-markdown.nvim
  {
    url = gh 'MeanderingProgrammer/render-markdown.nvim',
    commit = '4663eb3ecd538bd5062628fb6d95bbe6bdca78f6',
    ft = { 'markdown' },
    enabled = use 'render_markdown',
  },

  -- live-preview
  {
    url = gh 'brianhuster/live-preview.nvim',
    commit = 'a6307fa340ed7c0d96f5c567afc8c991aad94ce0',
    cmd = { 'LivePreview' },
    enabled = use 'live_preview',
  },

  -- grug-far.nvim
  {
    url = gh 'MagicDuck/grug-far.nvim',
    commit = '11595bf747edc270bce2069d1020502ad4ae56cf',
    cmd = { 'GrugFar' },
    keys = { { '<leader>sr', mode = { 'n', 'x' } } },
    enabled = use 'grug_far',
    config = function()
      map({ 'n', 'x' }, '<leader>sr', function()
        local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
        require('grug-far').open {
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
          },
        }
      end, { desc = 'Search and replace' })
    end,
  },
}

return spec