_G.Config = {
  enable_plugins = true,
  have_nerd_font = true,
  gh_proxy = {
    enabled = false,
    url = 'https://ghfast.top/',
  },
}

Config.gh = function(repo)
  if not Config.gh_proxy.enabled then
    return 'https://github.com/' .. repo
  end
  return Config.gh_proxy.url .. 'https://github.com/' .. repo
end
