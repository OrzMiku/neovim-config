local M = {}

function M.build(ev)
  if vim.fn.executable 'make' == 1 then
    vim.system({ 'make' }, { cwd = ev.data.path }):wait(300000)
  elseif vim.fn.executable 'mingw32-make' == 1 then
    vim.system({ 'mingw32-make' }, { cwd = ev.data.path }):wait(300000)
  end
end

return M
