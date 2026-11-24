# chimivim

A personal Neovim configuration.

> [!NOTE]
> This branch is AI slop and may be manually rewritten back into the main branch later.

- The latest Neovim release (0.12+) is recommended. This configuration follows current native APIs (including `vim.pack`) and does not maintain compatibility with older versions.
- External plugins are managed with native `vim.pack` (`:PackUpdate`, `:PackClean`, `<leader>tp`) and require Git when enabled.
- `rg` and `fzf` are required by the default search plugins; `fd` is optional.
- A Nerd Font is optional but recommended for icons; set `NVIM_CONFIG_HAVE_NERD_FONT=0` to use ASCII icons.
- A C compiler and the Tree-sitter CLI may be needed to install parsers.
- Language servers, formatters, and their runtimes should be installed as needed. Mason can be used to manage many of them.
- Set `NVIM_CONFIG_ENABLE_PLUGIN=0` to disable external plugins.

