---@class UserConfigFeatures
---@field enable_plugin boolean
---@field ui2 boolean
---@field clipboard_osc52 boolean
---@field have_nerd_font boolean

---@class UserConfigHooks
---@field before_basic fun()
---@field after_basic fun()
---@field before_plugin fun()
---@field after_plugin fun()

---@class UserConfig
---@field features UserConfigFeatures
---@field hooks UserConfigHooks

---@class UserConfigFeatureOverrides
---@field enable_plugin? boolean
---@field ui2? boolean
---@field clipboard_osc52? boolean
---@field have_nerd_font? boolean

---@class UserConfigHookOverrides
---@field before_basic? fun()
---@field after_basic? fun()
---@field before_plugin? fun()
---@field after_plugin? fun()

---@class UserConfigOverrides
---@field features? UserConfigFeatureOverrides
---@field hooks? UserConfigHookOverrides

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
local config = default_config

local function merge_config(src_config, dst_config)
  return vim.tbl_deep_extend('force', src_config, dst_config)
end

local function ensure_user_config()
  if vim.uv.fs_stat(userconfig_path) then
    return
  end

  local ok, err = vim.uv.fs_copyfile(userconfig_example_path, userconfig_path)
  if not ok then
    error(('Failed to create user config from example: %s'):format(err), 0)
  end
end

local function load_user_config()
  local ok, userconfig = pcall(require, 'user.config')
  if not ok then
    error(('Failed to load user config `%s`: %s'):format(userconfig_path, userconfig), 0)
  end

  if type(userconfig) ~= 'table' then
    error(('User config `%s` must return a table'):format(userconfig_path), 0)
  end

  ---@cast userconfig UserConfigOverrides
  return userconfig
end

function M.setup()
  ensure_user_config()

  local userconfig = load_user_config()
  config = merge_config(default_config, userconfig)
end

function M.get_config()
  return vim.deepcopy(config)
end

return M
