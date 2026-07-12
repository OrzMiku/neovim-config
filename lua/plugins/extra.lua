local gh = require('modules.plugin-util').gh
local userconfig = require('config').get_config()

return {
  {
    url = gh 'wakatime/vim-wakatime',
    name = 'vim-wakatime',
    enabled = userconfig.extra_plugins.vim_wakatime,
    lazy = false,
  },
}
