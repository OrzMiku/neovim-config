local M = {}

local create = vim.api.nvim_create_user_command

local function get_plugin_names(ArgLead)
  local plugins = vim.pack.get(nil, { info = false })
  local names = {}

  for _, p in ipairs(plugins) do
    local name = p.spec.name
    if name:find('^' .. ArgLead) then
      table.insert(names, name)
    end
  end

  table.sort(names)
  return names
end

function M.setup()
  create('LspInfo', 'checkhealth vim.lsp', {})
  create('TSInfo', 'checkhealth vim.treesitter', {})

  create('PackAdd', function(opts)
    vim.pack.add(opts.fargs)
  end, {
    nargs = '+',
    desc = 'Install or add plugins',
  })

  create('PackDelete', function(opts)
    vim.pack.del(opts.fargs, { force = opts.bang })
  end, {
    nargs = '+',
    bang = true,
    complete = get_plugin_names,
    desc = 'Remove plugins from disk',
  })

  create('PackUpdate', function(opts)
    local names = #opts.fargs > 0 and opts.fargs or nil
    vim.pack.update(names, { force = opts.bang })
  end, {
    nargs = '*',
    bang = true,
    complete = get_plugin_names,
    desc = 'Update plugins',
  })

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
