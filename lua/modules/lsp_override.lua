local M = {}

M.vtsls = {
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>cR', function()
      client:exec_cmd({
        title = 'Find All File References',
        command = 'typescript.findAllFileReferences',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }, { bufnr = bufnr }, function(err, res)
        if err then
          vim.notify(err.message or tostring(err), vim.log.levels.ERROR, { title = 'vtsls' })
          return
        end

        vim.fn.setqflist({}, ' ', {
          title = 'Find All File References',
          items = vim.lsp.util.locations_to_items(res or {}, client.offset_encoding),
        })
        vim.cmd 'copen'
      end)
    end, { buffer = bufnr, desc = 'Find All File References' })
  end,
}

return M
