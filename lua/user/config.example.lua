---@type UserConfig
return {
  features = {
    enable_plugin = false,
  },
  hooks = {
    after_plugin = function()
      vim.lsp.enable {
        'lua_ls',
      }
    end,
  },
}
