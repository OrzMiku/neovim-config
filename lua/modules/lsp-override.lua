local M = {}

M.vtsls = {
  on_attach = function(client, bufnr)
    vim.keymap.set('n', 'fr', function()
      client:exec_cmd({
        title = 'Find All File References',
        command = 'typescript.findAllFileReferences',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }, { bufnr = bufnr }, function(err, res)
        vim.fn.setqflist({}, ' ', {
          title = 'Find All File References',
          items = vim.lsp.util.locations_to_items(res, 'utf-8'),
        })
        vim.cmd 'copen'
      end)
    end, { desc = 'Find All File References' })
  end,
}

return M
