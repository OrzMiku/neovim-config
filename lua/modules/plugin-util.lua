local M = {}

local gh_proxy = require('config').get_config().features.gh_proxy

function M.gh(repo)
  if not gh_proxy.enabled then
    return 'https://github.com/' .. repo
  end
  return gh_proxy.url .. 'https://github.com/' .. repo
end

return M
