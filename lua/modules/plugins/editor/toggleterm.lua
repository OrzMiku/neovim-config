---@class TermOpts
---@field cmd? string
---@field create_if_not_exist? boolean
---@field direction? "float" | "horizontal" | "vertical"

local M = {}

---@param opts? TermOpts
local function new_terminal(opts)
  local term_cfg = opts or {}
  if term_cfg.create_if_not_exist == nil then
    term_cfg.create_if_not_exist = true
  end

  local terminal = require 'toggleterm.terminal'
  local all_terms = terminal.get_all(true)

  if not term_cfg.create_if_not_exist and term_cfg.cmd then
    for _, t in ipairs(all_terms) do
      if t.cmd == term_cfg.cmd then
        t:toggle()
        return
      end
    end
  end

  local next_id = 0
  for _, t in ipairs(all_terms) do
    if t.id > next_id then
      next_id = t.id
    end
  end
  next_id = next_id + 1

  if term_cfg.cmd then
    local Terminal = terminal.Terminal
    local new_term = Terminal:new {
      cmd = term_cfg.cmd,
      id = next_id,
      hidden = false,
    }
    new_term:toggle()
    return
  end

  vim.ui.input({
    prompt = vim.g.have_nerd_font and '󰆍 Shell Command:' or 'Shell Command: ',
    default = vim.o.shell,
  }, function(input)
    if not input or input == '' then
      return
    end
    local Terminal = terminal.Terminal
    local new_term = Terminal:new {
      cmd = input,
      id = next_id,
      hidden = false,
    }
    new_term:toggle()
  end)
end

function M.opts()
  return {
    open_mapping = [[<C-\>]],
    insert_mappings = true,
    terminal_mappings = true,
    direction = 'float',
  }
end

function M.keys()
  return {
    { '<leader>ts', '<cmd>TermSelect<cr>', desc = '[T]erm [S]elect' },
    {
      '<leader>lg',
      function()
        new_terminal {
          cmd = 'lazygit',
          create_if_not_exist = false,
          direction = 'float',
        }
      end,
      desc = '[L]azy[g]it',
    },
    {
      '<leader>tn',
      new_terminal,
      desc = '[T]erm [N]ew',
    },
  }
end

return M
