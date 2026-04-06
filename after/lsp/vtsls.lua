local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'
local vue_plugin_path = mason_path .. '/vue-language-server/node_modules/@vue/language-server'

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_plugin_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

local vtsls_config = {
  filetypes = tsserver_filetypes,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
}

return vtsls_config
