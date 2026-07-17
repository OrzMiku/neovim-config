local ChimiProgress = {}
local H = {}

ChimiProgress.config = {}
H.default_config = vim.deepcopy(ChimiProgress.config)

ChimiProgress.setup = function(config)
  _G.ChimiProgress = ChimiProgress
  ChimiProgress.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

  vim.api.nvim_create_autocmd('LspProgress', {
    group = vim.api.nvim_create_augroup('ChimiProgressLsp', { clear = true }),
    callback = function(ev)
      local params = ev.data.params
      local value = params.value
      local id = ('lsp.%d.%s'):format(ev.data.client_id, tostring(params.token))

      vim.api.nvim_echo({ { value.message or 'done' } }, false, {
        id = id,
        kind = 'progress',
        source = 'vim.lsp',
        title = value.title,
        status = value.kind ~= 'end' and 'running' or 'success',
        percent = value.percentage,
      })
    end,
  })
end

return ChimiProgress
