---@type UserConfig
return {
  features = {
    enable_plugin = false,
    ui2 = true,
    clipboard_osc52 = true,
    have_nerd_font = false,
  },
  hooks = {
    after_plugin = function()
      vim.lsp.enable {
        'lua_ls',
      }
    end,
  },
}
