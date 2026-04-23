--------------------------------------------------------------------------------
--- CONFIG SETUP
--------------------------------------------------------------------------------
require('user.config').setup {
  features = {
    lsp_enable = {
      vtsls = true,
      vuels = true,
      texlab = true,
      clangd = true,
      pyright = true,
    },
  },
  custom_filetypes = {
    extension = {
      vsh = 'glsl',
      fsh = 'glsl',
      vert = 'glsl',
      frag = 'glsl',
    },
  },
  ft_configs = {
    {
      ft = { 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass' },
      opts = {
        softtabstop = 2,
        shiftwidth = 2,
      },
    },
  },
}

--------------------------------------------------------------------------------
--- BASIC SETUP
--- Core Neovim configuration, excluding plugin configurations.
--------------------------------------------------------------------------------
require('user.basic').setup()

--------------------------------------------------------------------------------
--- PLUGIN SETUP
--- All plugin-related configurations.
--------------------------------------------------------------------------------
require('user.plugins').setup()
