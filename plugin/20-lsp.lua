-- Server defaults come from nvim-lspconfig; enable after plugins are configured.
if not Config.plugin_enabled 'lspconfig' then
  return
end

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= 'vtsls' then
      return
    end

    local bufnr = ev.buf
    vim.keymap.set('n', '<leader>fR', function()
      client:exec_cmd({
        title = 'Find All File References',
        command = 'typescript.findAllFileReferences',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }, { bufnr = bufnr }, function(err, result)
        if err then
          vim.notify(err.message or tostring(err), vim.log.levels.ERROR, { title = 'vtsls' })
          return
        end

        local items = vim.lsp.util.locations_to_items(result or {}, client.offset_encoding)
        vim.fn.setqflist({}, ' ', {
          title = 'Find All File References',
          items = items,
        })
        if #items == 0 then
          vim.notify('No file references found', vim.log.levels.INFO, { title = 'vtsls' })
          return
        end

        if Config.plugin_enabled 'fzf_lua' and vim.fn.executable 'fzf' == 1 then
          local loaded, fzf = pcall(require, 'fzf-lua')
          if loaded then
            local opened, picker = pcall(fzf.quickfix)
            if opened and picker then
              return
            end
          end
        end
        vim.cmd.copen()
      end)
    end, { buffer = bufnr, desc = 'Find all file references' })
  end,
})

vim.lsp.enable(Config.lsp.servers)
