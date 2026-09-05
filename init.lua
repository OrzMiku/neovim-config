--------------------------------------------------------------------------------
--- user config
--------------------------------------------------------------------------------
_G.UserConfig = {
  enable_plugin = vim.env.NVIM_PLUGINS ~= '0',
  have_nerd_font = true,
  lsp = {
    servers = { lua_ls = true },
  },
  formatter = {
    default_format_opts = { lsp_format = 'fallback' },
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
  },
  treesitter = {
    ensure_installed = { 'lua', 'markdown', 'markdown_inline' },
    auto_install = false,
    highlight = true,
  },
}

--------------------------------------------------------------------------------
--- preload
--------------------------------------------------------------------------------
vim.g.mapleader = ' '

--------------------------------------------------------------------------------
--- lazy.nvim bootstrap
--------------------------------------------------------------------------------
if UserConfig.enable_plugin then
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

  if not vim.uv.fs_stat(lazypath) then
    local repo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazypath }
  end

  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup {
    spec = require 'plugins',
    install = { colorscheme = { 'catppuccin' } },
  }
end

--------------------------------------------------------------------------------
--- configs
--------------------------------------------------------------------------------
require 'options'
require 'keymaps'
