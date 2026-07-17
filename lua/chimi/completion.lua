local ChimiCompletion = {}
local H = {}

ChimiCompletion.config = {
  autocomplete = true,
  autocompletedelay = 80,
  completeopt = 'fuzzy,menuone,popup,noselect',
  omnifunc = true,
  disable_in_special_buffers = true,
  lsp = true,
}

H.default_config = vim.deepcopy(ChimiCompletion.config)

ChimiCompletion.setup = function(config)
  _G.ChimiCompletion = ChimiCompletion
  ChimiCompletion.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  config = ChimiCompletion.config

  vim.opt.autocomplete = config.autocomplete
  vim.opt.autocompletedelay = config.autocompletedelay
  vim.opt.completeopt = config.completeopt
  if config.omnifunc then
    vim.opt.complete:append 'o'
  else
    vim.opt.complete:remove 'o'
  end

  if config.disable_in_special_buffers then
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('ChimiCompletionSpecialBuffer', { clear = true }),
      callback = function(ev)
        if vim.bo[ev.buf].buftype ~= '' then
          vim.bo[ev.buf].autocomplete = false
        end
      end,
    })
  end

  if config.lsp then
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('ChimiCompletionLsp', { clear = true }),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/completion', ev.buf) then
          vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
      end,
    })
  end
end

return ChimiCompletion
