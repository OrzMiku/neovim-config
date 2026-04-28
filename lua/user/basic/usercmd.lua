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

  create('PackDeleteUnused', function(opts)
    local plugins = vim.pack.get()
    local plugin_config = require 'user.plugins'
    local added_names = {}
    local unused = {}

    for _, plugin in ipairs(plugin_config.plugins) do
      local name = plugin_config.get_spec_name(plugin.spec)
      if name then
        added_names[name] = true
      end
    end

    for _, plugin in ipairs(plugins) do
      local name = plugin.spec.name
      if not added_names[name] then
        table.insert(unused, name)
      end
    end

    table.sort(unused)

    if #unused == 0 then
      vim.notify('No unused plugins to delete', vim.log.levels.INFO)
      return
    end

    vim.pack.del(unused, { force = opts.bang })
  end, {
    bang = true,
    desc = 'Delete plugins present in vim.pack.get() but absent from user.plugins.plugins_add',
  })
end

return M
