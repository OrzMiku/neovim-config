return {
  {
    'nvim-mini/mini.icons',
    lazy = true,
    opts = {
      style = UserConfig.have_nerd_font and 'glyph' or 'ascii',
    },
    config = function(_, opts)
      local icons = require 'mini.icons'
      icons.setup(opts)
      icons.mock_nvim_web_devicons()
    end,
  },
  {
    'nvim-mini/mini.extra',
    lazy = true,
    opts = {},
  },
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
  },
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'junegunn/fzf',
    lazy = true,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'catppuccin/nvim',
    main = 'catppuccin',
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin-nvim'
    end,
  },
  {
    'nvim-mini/mini.ai',
    event = 'VeryLazy',
    opts = {
      custom_textobjects = {
        B = function(...)
          return require('mini.extra').gen_ai_spec.buffer()(...)
        end,
      },
    },
  },
  {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-mini/mini.statusline',
    event = 'VeryLazy',
    opts = {},
    dependencies = { 'nvim-mini/mini.icons' },
  },
  {
    'nvim-mini/mini.indentscope',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'nvim-mini/mini.pairs',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      modes = { command = true },
    },
  },
  {
    'nvim-mini/mini.move',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { 'nvim-mini/mini.icons' },
    cmd = 'Oil',
    opts = {},
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'catppuccin/nvim', 'nvim-mini/mini.icons' },
    opts = function(_, opts)
      if type(opts.highlights) ~= 'function' then
        local theme = require('catppuccin.special.bufferline').get_theme()
        opts.highlights = vim.tbl_deep_extend('keep', opts.highlights or {}, type(theme) == 'function' and theme() or theme)
      end
      opts.options = vim.tbl_deep_extend('keep', opts.options or {}, { always_show_bufferline = false })
    end,
    keys = {
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle buffer pin' },
      { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Delete non-pinned buffers' },
      { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Delete buffers right' },
      { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Delete buffers left' },
      { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Pick buffer' },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>ns',
        function()
          require('dropbar.api').pick()
        end,
        desc = 'Pick winbar symbols',
      },
      {
        '[;',
        function()
          require('dropbar.api').goto_context_start()
        end,
        desc = 'Go to context start',
      },
      {
        '];',
        function()
          require('dropbar.api').select_next_context()
        end,
        desc = 'Select next context',
      },
    },
  },
  {
    'folke/which-key.nvim',
    cmd = 'WhichKey',
    dependencies = { 'nvim-mini/mini.icons' },
    event = 'VeryLazy',
    opts = {
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
    },
    keys = {
      {
        '<leader>hk',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps',
      },
    },
  },
  {
    'romus204/tree-sitter-manager.nvim',
    cmd = { 'TSManager', 'TSInstall', 'TSInstallSync', 'TSUninstall', 'TSUpdate', 'TSUpdateSync' },
    event = 'FileType',
    opts = vim.deepcopy(UserConfig.treesitter),
    keys = {
      { '<leader>ts', '<cmd>TSManager<cr>', desc = 'Treesitter manager' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'mason-org/mason.nvim' },
    opts = vim.deepcopy(UserConfig.lsp),
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client or client.name ~= 'vtsls' then
            return
          end

          local bufnr = ev.buf
          vim.keymap.set('n', '<leader>fR', function()
            client:exec_cmd({
              title = 'Find All File References',
              command = 'typescript.findAllFileReferences',
              arguments = { vim.uri_from_bufnr(bufnr) },
            }, { bufnr = bufnr }, function(err, result)
              if err then
                vim.notify(err.message or tostring(err), vim.log.levels.ERROR, { title = 'vtsls' })
                return
              end

              local items = vim.lsp.util.locations_to_items(result or {}, client.offset_encoding)
              vim.fn.setqflist({}, ' ', {
                title = 'Find All File References',
                items = items,
              })
              if #items == 0 then
                vim.notify('No file references found', vim.log.levels.INFO, { title = 'vtsls' })
                return
              end

              if vim.fn.executable 'fzf' == 1 then
                local loaded, fzf = pcall(require, 'fzf-lua')
                if loaded then
                  local opened, picker = pcall(fzf.quickfix)
                  if opened and picker then
                    return
                  end
                end
              end
              vim.cmd.copen()
            end)
          end, { buffer = bufnr, desc = 'Find all file references' })
        end,
      })

      for name, config in pairs(opts.servers or {}) do
        if config == false then
          vim.lsp.enable(name, false)
        elseif config == true then
          vim.lsp.enable(name)
        else
          vim.lsp.config(name, config)
          vim.lsp.enable(name)
        end
      end
    end,
  },
  {
    'mason-org/mason.nvim',
    lazy = false,
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonUpdate', 'MasonLog' },
    opts = {},
    keys = {
      { '<leader>tm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      sources = {
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
      },
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
    'j-hui/fidget.nvim',
    cmd = 'Fidget',
    event = 'LspAttach',
    opts = {},
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    opts = {
      options = {
        multilines = {
          enabled = true,
        },
      },
    },
  },
  {
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
          require('fzf-lua').global()
        end,
        desc = 'Find files, buffers and symbols',
      },
      {
        '<leader>sg',
        function()
          require('fzf-lua').live_grep()
        end,
        desc = 'Live grep',
      },
      {
        '<leader>hh',
        function()
          require('fzf-lua').helptags()
        end,
        desc = 'Find help',
      },
      {
        '<leader>fr',
        function()
          require('fzf-lua').resume()
        end,
        desc = 'Resume last picker',
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
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>nj',
        function()
          require('flash').jump()
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash',
      },
      {
        '<leader>nt',
        function()
          require('flash').treesitter()
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash Treesitter',
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    cmd = 'Gitsigns',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = desc,
            silent = true,
          })
        end

        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Next hunk')

        map('n', ']H', function()
          gitsigns.nav_hunk 'last'
        end, 'Last hunk')

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Previous hunk')

        map('n', '[H', function()
          gitsigns.nav_hunk 'first'
        end, 'First hunk')

        map('n', '<leader>gs', gitsigns.stage_hunk, 'Stage hunk')

        map('x', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Stage hunk')

        map('n', '<leader>gr', gitsigns.reset_hunk, 'Reset hunk')

        map('x', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Reset hunk')

        map('n', '<leader>gS', gitsigns.stage_buffer, 'Stage buffer')
        map('n', '<leader>gR', gitsigns.reset_buffer, 'Reset buffer')
        map('n', '<leader>gp', gitsigns.preview_hunk_inline, 'Preview hunk')

        map('n', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, 'Blame line')

        map('n', '<leader>gB', gitsigns.blame, 'Blame buffer')
        map('n', '<leader>gd', gitsigns.diffthis, 'Diff this')

        map('n', '<leader>gD', function()
          gitsigns.diffthis '~'
        end, 'Diff this ~')

        map('n', '<leader>gt', gitsigns.toggle_current_line_blame, 'Toggle line blame')
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
      end,
    },
  },
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    opts = { integrations = { diffview = true, fzf_lua = true } },
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'dlyongemallo/diffview-plus.nvim',
      'ibhagwan/fzf-lua',
    },
  },
  {
    'dlyongemallo/diffview-plus.nvim',
    main = 'diffview',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh', 'DiffviewFileHistory' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-mini/mini.icons' },
    opts = {},
  },
  {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    event = 'BufWritePre',
    opts = vim.deepcopy(UserConfig.formatter),
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format {}
        end,
        mode = { 'n', 'x' },
        desc = 'Code format',
      },
    },
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    dependencies = { 'junegunn/fzf' },
    opts = {},
  },
  {
    'stevearc/quicker.nvim',
    ft = 'qf',
    dependencies = { 'kevinhwang91/nvim-bqf' },
    opts = {
      keys = {
        {
          '>',
          function()
            require('quicker').expand {
              before = 2,
              after = 2,
              add_to_existing = true,
            }
          end,
          desc = 'Expand quickfix context',
        },
        {
          '<',
          function()
            require('quicker').collapse()
          end,
          desc = 'Collapse quickfix context',
        },
      },
    },
    keys = {
      {
        '<leader>xq',
        function()
          require('quicker').toggle { focus = true }
        end,
        desc = 'Toggle quickfix',
      },
      {
        '<leader>xl',
        function()
          require('quicker').toggle {
            focus = true,
            loclist = true,
          }
        end,
        desc = 'Toggle location list',
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    cmd = 'RenderMarkdown',
    dependencies = { 'romus204/tree-sitter-manager.nvim', 'nvim-mini/mini.icons' },
    opts = {},
  },
  {
    'brianhuster/live-preview.nvim',
    main = 'livepreview',
    cmd = 'LivePreview',
    dependencies = { 'ibhagwan/fzf-lua' },
    opts = {},
  },
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar', 'GrugFarWithin' },
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {},
    keys = {
      {
        '<leader>sr',
        function()
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'

          require('grug-far').open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'x' },
        desc = 'Search and replace',
      },
    },
  },
}
