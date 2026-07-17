local ChimiPicker = {}
local H = {}

ChimiPicker.config = {
  find = {
    depth = math.huge,
    exclude = { '.git', '.jj', 'node_modules' },
  },
  mappings = {
    files = '<leader>ff',
    grep = '<leader>fg',
    buffers = '<leader>fb',
    tabs = '<leader>ft',
    help = '<leader>fh',
    keymaps = '<leader>fk',
    oldfiles = '<leader>fo',
  },
}

H.default_config = vim.deepcopy(ChimiPicker.config)
H.files = nil
H.cwd = nil

ChimiPicker.setup = function(config)
  _G.ChimiPicker = ChimiPicker
  ChimiPicker.config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  vim.o.findfunc = "v:lua.require('chimi.picker').findfunc"

  if vim.fn.executable 'rg' == 1 then
    vim.opt.grepprg = 'rg --vimgrep --smart-case'
    vim.opt.grepformat = '%f:%l:%c:%m'
  end

  vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'DirChanged' }, {
    group = vim.api.nvim_create_augroup('ChimiPickerCache', { clear = true }),
    callback = H.clear_cache,
  })

  local mappings = ChimiPicker.config.mappings
  H.map(mappings.files, ChimiPicker.files, 'Find files')
  H.map(mappings.grep, ChimiPicker.grep, 'Grep')
  H.map(mappings.buffers, ChimiPicker.buffers, 'Find buffers')
  H.map(mappings.tabs, ChimiPicker.tabs, 'Find tabs')
  H.map(mappings.help, ChimiPicker.help, 'Find help')
  H.map(mappings.keymaps, ChimiPicker.keymaps, 'Show keymaps')
  H.map(mappings.oldfiles, ChimiPicker.oldfiles, 'Find old files')
end

ChimiPicker.findfunc = function(arg)
  local cwd = vim.fn.getcwd()
  if H.files == nil or H.cwd ~= cwd then
    H.cwd = cwd
    H.files = {}

    local find = ChimiPicker.config.find
    local excluded = vim.iter(find.exclude):fold({}, function(acc, name)
      acc[name] = true
      return acc
    end)

    local iterator = vim.fs.dir(cwd, {
      depth = find.depth,
      skip = function(dir)
        return not excluded[vim.fs.basename(dir)]
      end,
    })

    for name, kind in iterator do
      if kind == 'file' or kind == 'link' then
        H.files[#H.files + 1] = name
      end
    end
  end

  if arg == '' then
    return H.files
  end
  return vim.fn.matchfuzzy(H.files, arg)
end

ChimiPicker.files = function()
  H.feedkeys ':find '
end

ChimiPicker.grep = function()
  H.feedkeys ':grep '
end

ChimiPicker.buffers = function()
  local buffers = vim
    .iter(vim.api.nvim_list_bufs())
    :filter(function(bufnr)
      return vim.bo[bufnr].buflisted
    end)
    :totable()

  vim.ui.select(buffers, {
    prompt = 'Buffers',
    format_item = function(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      name = name ~= '' and vim.fn.fnamemodify(name, ':~:.') or '[No Name]'
      return ('%d: %s%s'):format(bufnr, name, vim.bo[bufnr].modified and ' [+]' or '')
    end,
  }, function(bufnr)
    if bufnr then
      vim.api.nvim_set_current_buf(bufnr)
    end
  end)
end

ChimiPicker.tabs = function()
  local tabs = vim.api.nvim_list_tabpages()
  vim.ui.select(tabs, {
    prompt = 'Tabs',
    format_item = function(tabpage)
      local number = vim.api.nvim_tabpage_get_number(tabpage)
      local window = vim.api.nvim_tabpage_get_win(tabpage)
      local bufnr = vim.api.nvim_win_get_buf(window)
      local name = vim.api.nvim_buf_get_name(bufnr)
      name = name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'
      return ('%d: %s'):format(number, name)
    end,
  }, function(tabpage)
    if tabpage then
      vim.api.nvim_set_current_tabpage(tabpage)
    end
  end)
end

ChimiPicker.help = function()
  H.feedkeys ':help '
end

ChimiPicker.keymaps = function()
  vim.cmd 'map'
end

ChimiPicker.oldfiles = function()
  local oldfiles = vim
    .iter(vim.v.oldfiles)
    :filter(function(path)
      return vim.uv.fs_stat(path) ~= nil
    end)
    :totable()

  vim.ui.select(oldfiles, { prompt = 'Old files' }, function(path)
    if path then
      vim.cmd.edit(vim.fn.fnameescape(path))
    end
  end)
end

H.clear_cache = function()
  H.files = nil
  H.cwd = nil
end

H.feedkeys = function(keys)
  vim.api.nvim_feedkeys(vim.keycode(keys), 'n', false)
end

H.map = function(lhs, rhs, desc)
  if lhs and lhs ~= '' then
    vim.keymap.set('n', lhs, rhs, { desc = desc })
  end
end

return ChimiPicker
