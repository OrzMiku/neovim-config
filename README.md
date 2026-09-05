# chimivim

A personal Neovim configuration.

- The latest Neovim release is always recommended. This configuration follows current native APIs and does not maintain compatibility with older versions.
- Git is required when external plugins are enabled.
- `rg` and `fzf` are required by the default search plugins; `fd` is optional.
- A Nerd Font is optional but recommended for icons.
- A C compiler and the Tree-sitter CLI may be needed to install parsers.
- Language servers, formatters, and their runtimes should be installed as needed. Mason can be used to manage many of them.
- Set `NVIM_PLUGINS=0` to disable external plugins.

## Keymaps

Leader defaults to Space. Custom commands use `<leader><group><action>`, except clipboard shortcuts: `<leader>y/Y/p/P` and `<leader>yr/ya` for relative/absolute paths.

| Group | Meaning |
| --- | --- |
| `b` | buffer |
| `c` | code |
| `f` | find |
| `s` | search |
| `g` | git |
| `x` | lists |
| `n` | navigation |
| `t` | tools |
| `h` | help |
