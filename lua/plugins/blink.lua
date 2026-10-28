return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  },
}
