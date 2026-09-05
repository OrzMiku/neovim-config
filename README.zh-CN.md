# chimivim

个人使用的 Neovim 配置文件。

- 始终推荐使用最新版本的 Neovim。本配置直接采用最新的原生 API，不考虑旧版本兼容。
- 启用外部插件时需要 Git。
- 默认搜索插件需要 `rg` 和 `fzf`；`fd` 为可选依赖。
- Nerd Font 为可选依赖，推荐用于图标显示。
- 安装 Tree-sitter parser 时可能需要 C 编译器和 Tree-sitter CLI。
- LSP、格式化工具及其运行环境按所使用的语言安装，其中许多工具可以通过 Mason 管理。
- 设置 `NVIM_PLUGINS=0` 可禁用外部插件。

## 快捷键

Leader 默认为空格。自定义命令使用 `<leader><group><action>`，剪贴板快捷键除外：`<leader>y/Y/p/P`，以及复制相对/绝对路径的 `<leader>yr/ya`。

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
