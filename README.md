# OrzMiku's Neovim Config

Personal Neovim config.

## Requirements

- Neovim `0.12.0` or newer.
- `git`
- A C toolchain for `telescope-fzf-native.nvim`
  - Linux/macOS: `make`
  - Windows: `make` or `mingw32-make`

## User Commands

- `:LspInfo`: open LSP health information
- `:TSInfo`: open Treesitter health information
- `:PackStatus`: print plugin status and revisions

## User Config

Create `userconf.lua` in the config root for user-specific settings. The file is optional, ignored by git, and may be empty. When it returns nil or does not exist, the defaults in `lua/config.lua` are used unchanged.

Use `userconf.example.lua` as a typed template:

```lua
return require('config').define {
  features = {
    lsp_enable = {
      bashls = true,
    },
  },
}
```
