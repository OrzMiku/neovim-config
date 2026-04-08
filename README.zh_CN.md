# OrzMiku 的 Neovim 配置

个人 Neovim 配置。基于原生 `pack.add` 驱动，没有懒加载。

## 运行要求

- Neovim `0.12.0` 或更高版本
- `git`
- 用于编译 `telescope-fzf-native.nvim` 的 C 工具链
  - Linux/macOS：`make`
  - Windows：`make` 或 `mingw32-make`

## 目录结构

```text
.
|-- init.lua
|-- after/lsp/vtsls.lua
`-- lua/user
    |-- basic/      # 选项、快捷键、自动命令、用户命令
    |-- lib/        # 小型辅助模块
    |-- plugins/    # 插件声明与配置
    `-- config.lua  # 面向用户的配置
```

## 用户命令

- `:LspInfo`：查看 LSP 健康状态
- `:TSInfo`：查看 Treesitter 健康状态
- `:PackAdd {plugin...}`：安装或添加插件
- `:PackDelete[!] {plugin...}`：从磁盘删除插件
- `:PackUpdate[!] [plugin...]`：更新全部或指定插件
- `:PackStatus`：打印插件状态与版本

