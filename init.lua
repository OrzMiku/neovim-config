--------------------------------------------------------------------------------
--- CONFIG SETUP
--------------------------------------------------------------------------------
require('user.config').setup {
  features = {
    lsp_enable = {
      bashls = true, -- bash-language-server
      fish_lsp = true, -- fish-lsp
      jsonls = true, -- json-lsp
      yamlls = true, -- yaml-language-server
      taplo = true, -- taplo
      marksman = true, -- marksman
      html = true, -- html-lsp
      cssls = true, -- css-lsp
      cssmodules_ls = true, -- cssmodules-language-server
      css_variables = true, -- css-variables-language-server
      vtsls = true, -- vtsls
      vue_ls = true, -- vue-language-server
      tailwindcss = true, -- tailwindcss-language-server
      emmet_ls = true, -- emmet-ls
      eslint = true, -- eslint-lsp
      clangd = true, -- clangd
      rust_analyzer = true, -- rust-analyzer
      pyright = true, -- pyright
      basedpyright = false, -- basedpyright
      texlab = true, -- texlab
      lemminx = true, -- lemminx
    },
    formatters_by_ft = {
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
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      objc = { 'clang_format' },
      objcpp = { 'clang_format' },
      cuda = { 'clang_format' },
      rust = { 'rustfmt' },
      python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
      xml = { 'xmlformat' },
    },
  },
  custom_filetypes = {
    extension = {
      vsh = 'glsl',
      fsh = 'glsl',
      vert = 'glsl',
      frag = 'glsl',
    },
  },
  ft_configs = {
    {
      ft = { 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass', 'json' },
      opts = {
        softtabstop = 2,
        shiftwidth = 2,
      },
    },
  },
}

--------------------------------------------------------------------------------
--- BASIC SETUP
--- Core Neovim configuration, excluding plugin configurations.
--------------------------------------------------------------------------------
require('user.basic').setup()

--------------------------------------------------------------------------------
--- PLUGIN SETUP
--- All plugin-related configurations.
--------------------------------------------------------------------------------
require('user.plugins').setup()
