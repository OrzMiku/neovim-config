local M = {}

M.langs = {
  lua = { ts = { 'lua' }, lsp = 'lua_ls', formatters = { 'stylua' } },
  javascript = { ts = { 'javascript', 'jsx' }, formatters = { 'prettier' } },
  typescript = { ts = { 'typescript', 'tsx' }, lsp = 'vtsls', formatters = { 'prettier' } },
  javascriptreact = { ts = { 'jsx' }, formatters = { 'prettier' } },
  typescriptreact = { ts = { 'tsx' }, formatters = { 'prettier' } },
  vue = { ts = { 'vue' }, lsp = 'vue_ls', formatters = { 'prettier' } },
  json = { ts = { 'json' }, lsp = 'jsonls', formatters = { 'prettier' } },
  toml = { ts = { 'toml' }, lsp = 'taplo', formatters = { 'toml' } },
  yaml = { ts = { 'yaml' }, lsp = 'yamlls', formatters = { 'prettier' } },
  markdown = { ts = { 'markdown', 'markdown_inline' }, lsp = 'marksman', formatters = { 'prettier', 'markdownlint' } },
  c = { ts = { 'c' }, formatters = { 'clang-format' } },
  cpp = { ts = { 'cpp' }, lsp = 'clangd', formatters = { 'clang-format' } },
  css = { ts = { 'css' }, lsp = 'cssls', formatters = { 'prettier' } },
  scss = { ts = { 'scss' }, formatters = { 'prettier' } },
  html = { ts = { 'html' }, lsp = 'html', formatters = { 'prettier' } },
  bash = { ts = { 'bash' } },
  glsl = { ts = { 'glsl' } },
  python = { ts = { 'python' } },
  rust = { ts = { 'rust' } },
  latex = { ts = { 'latex' }, lsp = 'texlab', formatters = { 'tex-fmt' } },
  xml = { ts = { 'xml' } },
  diff = { ts = { 'diff' } },
  dockerfile = { ts = { 'dockerfile' } },
  regex = { ts = { 'regex' } },
}

function M.get_ts_parsers()
  local parsers = {}
  for _, cfg in pairs(M.langs) do
    if cfg.ts then
      for _, p in ipairs(cfg.ts) do
        table.insert(parsers, p)
      end
    end
  end
  return parsers
end

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
