---@type UserConfig
return {
  hooks = {
    after_plugin = function()
      vim.lsp.enable {
        'lua_ls',
      }
    end,
  },
}
