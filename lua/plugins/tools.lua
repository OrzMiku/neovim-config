-- Deferred after first draw
vim.schedule(function()
  vim.cmd.packadd 'vim-wakatime'
  vim.cmd.packadd 'live-preview.nvim'

  vim.cmd.packadd 'open-by-http.nvim'
  require('open-by-http').setup {
    auto_start = false,
  }
end)
