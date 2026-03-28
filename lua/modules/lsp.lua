local M = {}

local map = function(keys, func, desc, mode, buf)
  vim.keymap.set(mode or 'n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
end

local vtsls_buf_setup = function(event)
  local bmap = function(keys, func, desc, mode)
    map(keys, func, desc, mode, event.buf)
  end
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.name == 'vtsls' then
    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    bmap('gF', function()
      local command_params = {
        command = 'typescript.findAllFileReferences',
        arguments = { params.textDocument.uri },
      }

      vim.lsp.buf_request(0, 'workspace/executeCommand', command_params, function(err, result)
        if err then
          vim.notify('VTSLS Error: ' .. err.message, vim.log.levels.ERROR)
          return
        end
        if not result or vim.tbl_isempty(result) then
          vim.notify('No file references found', vim.log.levels.INFO)
          return
        end
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local make_entry = function(entry)
          local filename = vim.uri_to_fname(entry.uri)
          local line = entry.range.start.line + 1
          local col = entry.range.start.character + 1
          local display_filename = vim.fn.fnamemodify(filename, ':.')
          return {
            value = entry,
            display = string.format('%s [%d:%d]', display_filename, line, col),
            ordinal = display_filename .. ' ' .. line,
            filename = filename,
            lnum = line,
            col = col,
          }
        end
        local conf = require('telescope.config').values

        pickers
          .new({}, {
            prompt_title = 'VTSLS File References',
            finder = finders.new_table {
              results = result,
              entry_maker = make_entry,
            },
            previewer = conf.qflist_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end)
    end, 'Find File References (vtsls)', 'n')
  end
end

local lsp_buf_setup = function(event)
  local bmap = function(keys, func, desc, mode)
    map(keys, func, desc, mode, event.buf)
  end
  bmap('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  bmap('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  bmap('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  bmap('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  bmap('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  bmap('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  bmap('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
  bmap('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
  bmap('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

  -- for vtsls plugin
  vtsls_buf_setup(event)
end

function M.setup()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
    callback = lsp_buf_setup,
  })
end

return M
