---@alias UserConfig {
---  features: {
---    enable_plugin: boolean,
---    ui2: boolean,
---    clipboard_osc52: boolean,
---    have_nerd_font: boolean,
---  },
---  hooks: {
---    before_basic: fun(),
---    after_basic: fun(),
---    before_plugin: fun(),
---    after_plugin: fun(),
---  },
---}

local M = {}

local userconfig_path = vim.fn.stdpath 'config' .. '/lua/user/config.lua'
local userconfig_example_path = vim.fn.stdpath 'config' .. '/lua/user/config.example.lua'

---@type UserConfig
local default_config = {
  features = {
    enable_plugin = false,
    ui2 = true,
    clipboard_osc52 = true,
    have_nerd_font = false,
  },
  hooks = {
    before_basic = function() end,
    after_basic = function() end,
    before_plugin = function() end,
    after_plugin = function() end,
  },
}

---@type UserConfig
local config = {}

local function merge_config(src_config, dst_config)
  return vim.tbl_deep_extend('force', src_config, dst_config)
end

function M.setup()
  if not vim.uv.fs_stat(userconfig_path) then
    vim.uv.fs_copyfile(userconfig_example_path, userconfig_path)
  end
  local userconfig = require 'user.config'
  config = merge_config(default_config, userconfig)
end

function M.get_config()
  return vim.deepcopy(config)
end

return M
