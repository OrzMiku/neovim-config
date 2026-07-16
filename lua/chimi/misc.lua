local ChimiMisc = {}
local H = {}

ChimiMisc.setup = function(config)
  -- export module
  _G.ChimiMisc = ChimiMisc

  -- setup config
  config = H.setup_config(config)
end

ChimiMisc.config = {
  gh_proxy = {
    enable = false,
    base_url = 'https://ghfast.top/https://github.com/',
  },
}

H.default_config = vim.deepcopy(ChimiMisc.config)

H.setup_config = function(config)
  config = vim.tbl_deep_extend('force', H.default_config, config or {})
  return config
end

ChimiMisc.gh = function(repo)
  local gh_proxy = ChimiMisc.config.gh_proxy

  if gh_proxy.enable then
    return gh_proxy.base_url .. repo
  end

  return 'https://github.com/' .. repo
end

ChimiMisc.lsp_override = {}

ChimiMisc.lsp_override.vtsls = {
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>cR', function()
      client:exec_cmd({
        title = 'Find All File References',
        command = 'typescript.findAllFileReferences',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }, { bufnr = bufnr }, function(err, res)
        if err then
          vim.notify(err.message or tostring(err), vim.log.levels.ERROR, { title = 'vtsls' })
          return
        end

        vim.fn.setqflist({}, ' ', {
          title = 'Find All File References',
          items = vim.lsp.util.locations_to_items(res or {}, client.offset_encoding),
        })
        vim.cmd 'copen'
      end)
    end, { buffer = bufnr, desc = 'Find All File References' })
  end,
}

return ChimiMisc
