return {
  'nvim-telescope/telescope-fzf-native.nvim',
  build = function(plugin)
    if vim.fn.executable 'make' == 1 then
      vim.system({ 'make' }, { cwd = plugin.path }):wait(300000)
    elseif vim.fn.executable 'mingw32-make' == 1 then
      vim.system({ 'mingw32-make' }, { cwd = plugin.path }):wait(300000)
    end
  end,
  lazy = true,
}
