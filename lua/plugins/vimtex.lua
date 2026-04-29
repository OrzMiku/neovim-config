local user_config = require('config').get_config()
local uv = vim.uv or vim.loop
local os_name = uv.os_uname().sysname

local function expand_env_vars(value)
  return (value:gsub('%${([^}]+)}', function(name)
    return os.getenv(name) or ''
  end))
end

local function get_first_executable(candidates)
  if not candidates or #candidates == 0 then
    return nil
  end

  local fallback = expand_env_vars(candidates[1])
  for _, candidate in ipairs(candidates) do
    local expanded = expand_env_vars(candidate)
    if vim.fn.executable(expanded) == 1 then
      return expanded
    end
  end

  return fallback
end

return {
  'lervag/vimtex',
  enabled = user_config.features.vimtex.enabled,
  config = function()
    local user_config = require('config').get_config()
    local viewer_config = user_config.vimtex.viewers[os_name]
    if not viewer_config then
      return
    end

    vim.g.vimtex_view_method = viewer_config.method

    local viewer = get_first_executable(viewer_config.viewer_candidates)
    if viewer then
      vim.g.vimtex_view_general_viewer = viewer
    end

    if viewer_config.options then
      vim.g.vimtex_view_general_options = viewer_config.options
    end
  end,
}
