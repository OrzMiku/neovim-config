---@class User.Config.Config
---@field features? User.Config.Config.Features
---@field colorscheme? User.Config.Config.Colorscheme
---@field opts? table<string, any>
---@field custom_filetypes? table<any, any>
---@field ft_configs? User.Config.Config.FiletypeConfig[]

---@class User.Config.Config.Colorscheme
---@field name? string
---@field preload? string

---@class User.Config.Config.Features
---@field ui2? boolean
---@field clipboard_osc52? boolean
---@field have_nerd_font? boolean
---@field lsp_enable? table<string, boolean>
---@field formatters_by_ft? table<string, table>
---@field vimtex? User.Config.Config.Vimtex
---@field orgmode? table

---@class User.Config.Config.FiletypeConfig
---@field ft string[]
---@field opts? table<string, any>
---@field on? function(bufnr)

---@class User.Config.Config.Vimtex
---@field enabled boolean
---@field viewers? table<string, User.Config.Config.VimtexViewer>

---@class User.Config.Config.VimtexViewer
---@field method string
---@field viewer_candidates? string[]
---@field options? string
---@type User.Config.Config

local M = {}

---@type User.Config.Config
local default_config = {
  features = {
    ui2 = true,
    clipboard_osc52 = true,
    have_nerd_font = true,
    lsp_enable = {
      lua_ls = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
    },
    vimtex = {
      enabled = false,
      viewers = {
        Windows_NT = {
          method = 'general',
          viewer_candidates = {
            'SumatraPDF',
            '${LOCALAPPDATA}/SumatraPDF/SumatraPDF.exe',
          },
          options = [[-reuse-instance -forward-search @tex @line @pdf]],
        },
        Linux = {
          method = 'zathura',
        },
        Darwin = {
          method = 'skim',
        },
      },
    },
    orgmode = {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    },
  },
  colorscheme = {
    preload = 'catppuccin',
    name = 'catppuccin-nvim',
  },
  opts = {
    number = true,
    relativenumber = true,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    autoindent = true,
    smartindent = true,
    clipboard = 'unnamedplus',
    undofile = true,
    smartcase = true,
    ignorecase = true,
    splitbelow = true,
    splitright = true,
    list = true,
    cursorline = true,
    scrolloff = 10,
    confirm = true,
  },
  custom_filetypes = {},
  ft_configs = {
    {
      ft = { 'make', 'gitconfig' },
      opts = {
        softtabstop = 8,
        shiftwidth = 8,
        expandtab = false,
      },
    },
  },
}

local config = vim.deepcopy(default_config)

local user_config_file = vim.fn.stdpath 'config' .. '/userconf.lua'

---@param base_config User.Config.Config
---@param user_config? User.Config.Config
---@return User.Config.Config
local function merge_config(base_config, user_config)
  user_config = user_config or {}
  local user_ft_configs = user_config.ft_configs
  local config_without_ft = vim.deepcopy(user_config)
  config_without_ft.ft_configs = nil

  local merged_config = vim.tbl_deep_extend('force', vim.deepcopy(base_config), config_without_ft)

  if user_ft_configs and type(user_ft_configs) == 'table' then
    vim.list_extend(merged_config.ft_configs, user_ft_configs)
  end

  return merged_config
end

---@return User.Config.Config?
local function load_user_config()
  if vim.fn.filereadable(user_config_file) ~= 1 then
    return nil
  end

  local user_config = dofile(user_config_file)
  if user_config == nil then
    return nil
  end
  if type(user_config) ~= 'table' then
    error(string.format('%s must return a table or nil', user_config_file))
  end

  return user_config
end

function M.setup()
  config = merge_config(default_config, load_user_config())
end

---@param user_config User.Config.Config
---@return User.Config.Config
function M.define(user_config)
  return user_config
end

---@return User.Config.Config
function M.get_config()
  return vim.deepcopy(config)
end

return M
