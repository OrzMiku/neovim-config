_G.Config = {
  enable_plugins = vim.env.NVIM_PLUGINS ~= '0',
  have_nerd_font = true,
  github = {
    proxy = {
      enabled = false,
      base_url = 'https://ghfast.top/https://github.com/',
    },
  },
  lsp = {
    servers = { 'lua_ls' },
  },
  plugins = {
    catppuccin = true,
    mini = {
      enabled = true,
      icons = true,
      ai = true,
      surround = true,
      statusline = true,
      indentscope = true,
      pairs = true,
      move = true,
    },
    oil = true,
    bufferline = true,
    dropbar = true,
    which_key = true,
    tree_sitter_manager = true,
    lspconfig = true,
    mason = true,
    lazydev = true,
    fidget = true,
    blink_cmp = true,
    tiny_inline_diagnostic = true,
    fzf_lua = true,
    flash = true,
    gitsigns = true,
    neogit = true,
    conform = true,
    bqf = true,
    quicker = true,
    render_markdown = true,
    live_preview = true,
    grug_far = true,
  },
}

Config.github_url = function(repo)
  local proxy = Config.github.proxy
  return (proxy.enabled and proxy.base_url or 'https://github.com/') .. repo
end

Config.plugin_enabled = function(name)
  if not Config.enable_plugins then
    return false
  end

  local value = Config.plugins[name]
  if type(value) == 'table' then
    return value.enabled ~= false
  end

  return value == true
end

Config.plugin_feature_enabled = function(name, feature)
  if not Config.plugin_enabled(name) then
    return false
  end

  local value = Config.plugins[name]
  return type(value) ~= 'table' or value[feature] ~= false
end

--------------------------------------------------------------------------------
--- Plugin manager: lazy.nvim
--------------------------------------------------------------------------------

-- mapleader 需在 lazy 加载期前就位（早于 00-core.lua 执行）
if vim.g.mapleader == nil then
  vim.g.mapleader = ' '
end

if Config.enable_plugins then
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      Config.github_url 'folke/lazy.nvim',
      '--branch=stable',
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
  require('lazy').setup {
    spec = require 'plugins',
    defaults = {
      lazy = true,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          'netrwPlugin',
          'rplugin',
          'spellfile',
          'tarPlugin',
          'tutor',
          'zipPlugin',
        },
      },
    },
  }
end
