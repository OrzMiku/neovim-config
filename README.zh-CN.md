# chimivim

个人使用的 Neovim 配置文件。

> [!NOTE]
> 本分支为 AI slop，后续可能会人工重写并合回主分支。

- 推荐使用最新版本的 Neovim（0.12+）。本配置直接采用最新的原生 API（包括 `vim.pack`），不考虑旧版本兼容。
- 外部插件使用原生 `vim.pack` 管理（`:PackUpdate`、`:PackClean`、`<leader>tp`），启用时需要 Git。
- 默认搜索插件需要 `rg` 和 `fzf`；`fd` 为可选依赖。
- Nerd Font 为可选依赖，推荐用于图标显示；设置 `NVIM_CONFIG_HAVE_NERD_FONT=0` 可切换为 ASCII 图标。
- 安装 Tree-sitter parser 时可能需要 C 编译器和 Tree-sitter CLI。
- LSP、格式化工具及其运行环境按所使用的语言安装，其中许多工具可以通过 Mason 管理。
- 设置 `NVIM_CONFIG_ENABLE_PLUGIN=0` 可禁用外部插件。

