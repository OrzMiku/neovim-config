local M = {}

--------------------------------------------------------------------------------
--- type definition
--------------------------------------------------------------------------------

---@class User.Config.Config
---@field features? User.Config.Config.Features
---@field opts? table<string, any>
---@field custom_filetypes? table<any, any>
---@field ft_configs? User.Config.Config.FiletypeConfig[]
---@field vimtex? User.Config.Config.Vimtex

---@class User.Config.Config.Features
---@field clipboard_osc52? boolean
---@field have_nerd_font? boolean
---@field lsp_enable? table<string, boolean>
---@field formatters_by_ft? table<string, table>

---@class User.Config.Config.FiletypeConfig
---@field ft string[]
---@field opts? table<string, any>
---@field on? function(bufnr)

---@class User.Config.Config.Vimtex
---@field viewers? table<string, User.Config.Config.VimtexViewer>

---@class User.Config.Config.VimtexViewer
---@field method string
---@field viewer_candidates? string[]
---@field options? string
---@type User.Config.Config

--------------------------------------------------------------------------------
--- implementation
--------------------------------------------------------------------------------

---@type User.Config.Config
local default_config = {
  features = {
    clipboard_osc52 = true,
    have_nerd_font = true,
    lsp_enable = {
      lua_ls = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
    },
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
  vimtex = {
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
}

local config = vim.deepcopy(default_config)

---@param user_config? User.Config.Config
function M.setup(user_config)
  user_config = user_config or {}
  local user_ft_configs = user_config.ft_configs
  user_config.ft_configs = nil

  config = vim.tbl_deep_extend('force', vim.deepcopy(default_config), user_config or {})

  if user_ft_configs and type(user_ft_configs) == 'table' then
    vim.list_extend(config.ft_configs, user_ft_configs)
  end
end

---@return User.Config.Config
function M.get_config()
  return vim.deepcopy(config)
end

return M
