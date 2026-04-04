local M = {}

vim.filetype.add {
  extension = {
    vsh = 'glsl',
    fsh = 'glsl',
    vert = 'glsl',
    frag = 'glsl',
  },
}

M.langs = {
  lua = { lsp = 'lua_ls', formatters = { 'stylua' } },
  javascript = { formatters = { 'prettier' } },
  typescript = { lsp = 'vtsls', formatters = { 'prettier' } },
  javascriptreact = { formatters = { 'prettier' } },
  typescriptreact = { formatters = { 'prettier' } },
  vue = { lsp = 'vue_ls', formatters = { 'prettier' } },
  json = { lsp = 'jsonls', formatters = { 'prettier' } },
  toml = { lsp = 'taplo', formatters = { 'toml' } },
  yaml = { lsp = 'yamlls', formatters = { 'prettier' } },
  markdown = { lsp = 'marksman', formatters = { 'prettier', 'markdownlint' } },
  c = { formatters = { 'clang-format' } },
  cpp = { lsp = 'clangd', formatters = { 'clang-format' } },
  css = { lsp = 'cssls', formatters = { 'prettier' } },
  scss = { formatters = { 'prettier' } },
  html = { lsp = 'html', formatters = { 'prettier' } },
  latex = { lsp = 'texlab', formatters = { 'tex-fmt' } },
}

function M.get_lsp_servers()
  local servers = {}
  for _, cfg in pairs(M.langs) do
    if cfg.lsp then
      table.insert(servers, cfg.lsp)
    end
  end
  return servers
end

function M.get_formatters()
  local formatters = {}
  for ft, cfg in pairs(M.langs) do
    if cfg.formatters then
      formatters[ft] = cfg.formatters
    end
  end
  return formatters
end

return M
