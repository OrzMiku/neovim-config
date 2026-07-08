local gh = require('modules.plugin-util').gh

local function dap_call(method)
  return function()
    require('dap')[method]()
  end
end

local function dapui_call(method)
  return function()
    require('dapui')[method]()
  end
end

local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  local args_str = type(args) == 'table' and table.concat(args, ' ') or args
  config = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str))
    if config.type == 'java' then
      return new_args
    end
    return require('dap.utils').splitstr(new_args)
  end
  return config
end

return {
  {
    url = gh 'mfussenegger/nvim-dap',
    name = 'nvim-dap',
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'DAP conditional breakpoint',
      },
      { '<leader>db', dap_call 'toggle_breakpoint', desc = 'DAP toggle breakpoint' },
      {
        '<leader>da',
        function()
          require('dap').continue { before = get_args }
        end,
        desc = 'DAP run with args',
      },
      { '<leader>dc', dap_call 'continue', desc = 'DAP continue' },
      { '<leader>dC', dap_call 'run_to_cursor', desc = 'DAP run to cursor' },
      { '<leader>dg', dap_call 'goto_', desc = 'DAP go to line' },
      {
        '<leader>dh',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'DAP hover widgets',
      },
      { '<leader>di', dap_call 'step_into', desc = 'DAP step into' },
      { '<leader>dj', dap_call 'down', desc = 'DAP down stack frame' },
      { '<leader>dk', dap_call 'up', desc = 'DAP up stack frame' },
      { '<leader>dl', dap_call 'run_last', desc = 'DAP run last' },
      { '<leader>do', dap_call 'step_out', desc = 'DAP step out' },
      { '<leader>dO', dap_call 'step_over', desc = 'DAP step over' },
      { '<leader>dP', dap_call 'pause', desc = 'DAP pause' },
      { '<leader>dq', dap_call 'close', desc = 'DAP close session' },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'DAP toggle REPL',
      },
      { '<leader>dR', dap_call 'restart', desc = 'DAP restart' },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = 'DAP session',
      },
      { '<leader>dt', dap_call 'terminate', desc = 'DAP terminate' },
    },
    dependencies = {
      {
        url = gh 'rcarriga/nvim-dap-ui',
        name = 'nvim-dap-ui',
        keys = {
          {
            '<leader>de',
            function()
              require('dapui').eval()
            end,
            mode = { 'n', 'x' },
            desc = 'DAP eval',
          },
          { '<leader>du', dapui_call 'toggle', desc = 'DAP UI toggle' },
          {
            '<leader>dE',
            function()
              vim.ui.input({ prompt = 'Expression: ' }, function(expr)
                if expr then
                  require('dapui').eval(expr, { enter = true })
                end
              end)
            end,
            desc = 'DAP eval input',
          },
        },
        opts = {},
        config = function(_, opts)
          local dap = require 'dap'
          local dapui = require 'dapui'
          dapui.setup(opts)

          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open {}
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close {}
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close {}
          end
        end,
        dependencies = {
          {
            url = gh 'nvim-neotest/nvim-nio',
            name = 'nvim-nio',
            lazy = true,
          },
        },
      },
      {
        url = gh 'theHamsta/nvim-dap-virtual-text',
        name = 'nvim-dap-virtual-text',
        lazy = true,
        opts = {},
      },
      {
        url = gh 'jay-babu/mason-nvim-dap.nvim',
        name = 'mason-nvim-dap.nvim',
        lazy = true,
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          automatic_installation = true,
          ensure_installed = {},
          handlers = {},
        },
        dependencies = {
          {
            url = gh 'mason-org/mason.nvim',
            name = 'mason.nvim',
          },
        },
      },
      {
        url = gh 'nvim-lua/plenary.nvim',
        name = 'plenary.nvim',
        lazy = true,
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
      vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DapLogPoint', { text = 'L', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DapStopped', { text = '>', texthl = 'DiagnosticSignWarn', linehl = 'DapStoppedLine' })
      vim.fn.sign_define('DapBreakpointRejected', { text = 'R', texthl = 'DiagnosticSignError' })

      local vscode = require 'dap.ext.vscode'
      vscode.json_decode = function(str)
        return vim.json.decode(require('plenary.json').json_strip_comments(str))
      end
    end,
  },
}
