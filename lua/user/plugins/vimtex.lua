local M = {}

local uv = vim.uv or vim.loop
local os_name = uv.os_uname().sysname

local function get_sumatra_path()
  local sumatra_path = 'SumatraPDF'
  local local_appdata = os.getenv 'LOCALAPPDATA'
  local default_local_path = local_appdata .. '/SumatraPDF/SumatraPDF.exe'
  if vim.fn.executable 'SumatraPDF' == 1 then
    sumatra_path = 'SumatraPDF'
  elseif vim.fn.executable(default_local_path) == 1 then
    sumatra_path = default_local_path
  end
  return sumatra_path
end

function M.setup()
  if os_name == 'Windows_NT' then
    vim.g.vimtex_view_method = 'general'
    local sumatra_path = get_sumatra_path()
    vim.g.vimtex_view_general_viewer = sumatra_path
    vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
  elseif os_name == 'Linux' then
    vim.g.vimtex_view_method = 'zathura'
  elseif os_name == 'Darwin' then
    vim.g.vimtex_view_method = 'skim'
  end
end

return M
