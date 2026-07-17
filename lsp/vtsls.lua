local function on_attach(client, bufnr)
  vim.keymap.set('n', '<leader>cR', function()
    client:exec_cmd({
      title = 'Find All File References',
      command = 'typescript.findAllFileReferences',
      arguments = { vim.uri_from_bufnr(bufnr) },
    }, { bufnr = bufnr }, function(err, result)
      if err then
        vim.notify(err.message or tostring(err), vim.log.levels.ERROR, { title = 'vtsls' })
        return
      end

      vim.fn.setqflist({}, ' ', {
        title = 'Find All File References',
        items = vim.lsp.util.locations_to_items(result or {}, client.offset_encoding),
      })
      vim.cmd.copen()
    end)
  end, { buffer = bufnr, desc = 'Find all file references' })
end

---@type vim.lsp.Config
return {
  cmd = { 'vtsls', '--stdio' },
  init_options = {
    hostInfo = 'neovim',
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_dir = function(bufnr, on_dir)
    local project_root = vim.fs.root(bufnr, {
      { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
      { '.git' },
    })
    local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' })

    if deno_root and (not project_root or #deno_root >= #project_root) then
      return
    end

    on_dir(project_root or vim.fn.getcwd())
  end,
  on_attach = on_attach,
}
