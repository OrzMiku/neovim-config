# OrzMiku's Neovim Config

Personal Neovim config. Powered by native `pack.add` without lazy loading.

## Requirements

- Neovim `0.12.0` or newer.
- `git`
- A C toolchain for `telescope-fzf-native.nvim`
  - Linux/macOS: `make`
  - Windows: `make` or `mingw32-make`

## Structure

```text
.
|-- init.lua
|-- after/lsp/vtsls.lua
`-- lua/user
    |-- basic/      # options, keymaps, autocmds, user commands
    |-- lib/        # small helpers
    |-- plugins/    # plugin specs and setup
    `-- config.lua  # user-facing config
```

## User Commands

- `:LspInfo`: open LSP health information
- `:TSInfo`: open Treesitter health information
- `:PackAdd {plugin...}`: install or add plugins
- `:PackDelete[!] {plugin...}`: remove plugins from disk
- `:PackUpdate[!] [plugin...]`: update all plugins or selected ones
- `:PackStatus`: print plugin status and revisions

