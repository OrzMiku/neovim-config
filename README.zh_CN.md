# OrzMiku 的 Neovim 配置

个人 Neovim 配置。

## 运行要求

- Neovim `0.12.0` 或更高版本
- `git`
- 用于编译 `telescope-fzf-native.nvim` 的 C 工具链
  - Linux/macOS：`make`
  - Windows：`make` 或 `mingw32-make`

## 用户命令

- `:LspInfo`：查看 LSP 健康状态
- `:TSInfo`：查看 Treesitter 健康状态
- `:PackStatus`：打印插件状态与版本

## 用户配置

在配置根目录创建 `userconf.lua`，作为用户特定的配置入口。该文件是可选的，已被 git 忽略，并且可以为空。文件返回 nil 或不存在时，会直接使用 `lua/config.lua` 中的默认配置。

可以使用 `userconf.example.lua` 作为带类型提示的模板：

```lua
return require('config').define {
  features = {
    lsp_enable = {
      bashls = true,
    },
  },
}
```
