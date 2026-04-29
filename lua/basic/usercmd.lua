local M = {}

local create = vim.api.nvim_create_user_command

function M.setup()
  create('LspInfo', 'checkhealth vim.lsp', {})
  create('TSInfo', 'checkhealth vim.treesitter', {})

  create('PackStatus', function()
    local plugins = vim.pack.get()
    print(string.format('%-20s | %-10s | %s', 'Plugin', 'Status', 'Rev'))
    print(string.rep('-', 50))
    for _, p in ipairs(plugins) do
      local status = p.active and 'Active' or 'Inactive'
      print(string.format('%-20s | %-10s | %s', p.spec.name, status, p.rev:sub(1, 7)))
    end
  end, {
    desc = 'Show managed plugins status',
  })
end

return M
