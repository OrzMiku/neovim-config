local ChimiCmdline = {}
local H = {}

ChimiCmdline.config = {
  autocomplete = true,
  wildmode = 'noselect:lastused,full',
  wildoptions = 'pum,fuzzy',
}

H.default_config = vim.deepcopy(ChimiCmdline.config)

ChimiCmdline.setup = function(config)
  _G.ChimiCmdline = ChimiCmdline
  ChimiCmdline.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  config = ChimiCmdline.config

  vim.opt.wildmode = config.wildmode
  vim.opt.wildoptions = config.wildoptions

  if config.autocomplete then
    vim.api.nvim_create_autocmd('CmdlineChanged', {
      group = vim.api.nvim_create_augroup('ChimiCmdlineAutocomplete', { clear = true }),
      pattern = { ':', '/', '?' },
      callback = function()
        vim.fn.wildtrigger()
      end,
    })
  end
end

return ChimiCmdline
