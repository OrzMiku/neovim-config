local M = {}

function _G.simple_tabline()
  local curr_buf = vim.api.nvim_get_current_buf()
  local parts = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then
      local name = vim.api.nvim_buf_get_name(bufnr)
      name = (name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'):gsub('%%', '%%%%')

      if bufnr == curr_buf then
        table.insert(parts, '%#TabLineSel#')
      else
        table.insert(parts, '%#TabLine#')
      end

      local modified = vim.bo[bufnr].modified and '*' or ''
      table.insert(parts, ' ' .. name .. modified .. ' ')
    end
  end

  table.insert(parts, '%#TabLineFill#%=')
  return table.concat(parts)
end

function M.setup()
  vim.opt.number = true
  vim.opt.relativenumber = false
  vim.opt.expandtab = true
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.smartindent = true
  vim.opt.list = true
  vim.opt.foldtext = ''
  vim.opt.foldlevel = 99
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.opt.undofile = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.splitbelow = true
  vim.opt.splitright = true
  vim.opt.autocomplete = true
  vim.opt.complete:append 'o'
  vim.opt.completeopt = 'fuzzy,menuone,popup,noselect'
  vim.opt.pumborder = 'single'
  vim.opt.statusline:append " [%{&filetype ==# '' ? 'none' : &filetype }|%{&fileformat}]"
  vim.opt.showtabline = 2
  vim.opt.tabline = '%!v:lua.simple_tabline()'
  vim.opt.scrolloff = 3
end

return M
