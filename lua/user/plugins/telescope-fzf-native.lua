local M = {}

local augroup = require('user.lib.augroup').create

function M.build()
  vim.api.nvim_create_autocmd('PackChanged', {
    group = augroup 'UserPackChanged',
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
        if vim.fn.executable 'make' == 1 then
          vim.system({ 'make' }, { cwd = ev.data.path }):wait(300000)
        elseif vim.fn.executable 'mingw32-make' == 1 then
          vim.system({ 'mingw32-make' }, { cwd = ev.data.path }):wait(300000)
        end
      end
    end,
  })
end

return M
