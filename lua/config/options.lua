-- leader 键设置
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerd 字体 (如果没有 nerd 字体，需要设置为 false)
vim.g.have_nerd_font = true

-- 启用行号和相对行号
vim.o.number = true
vim.o.relativenumber = true

-- 启用鼠标模式
vim.o.mouse = 'a'

-- 不显示模式，通过状态栏显示
vim.o.showmode = false

-- 剪贴板
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- 缩进设置
vim.o.breakindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- 保存撤销历史
vim.o.undofile = true

-- 智能区分大小写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 默认保持 signcolumn 开启
vim.o.signcolumn = 'yes'

-- 减少更新时间
vim.o.updatetime = 300

-- 减少映射序列等待时间
vim.o.timeoutlen = 300

-- 新分割窗口的打开方式
vim.o.splitright = true
vim.o.splitbelow = true

-- 空白字符显示方式
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- 实时预览替换
vim.o.inccommand = 'split'

-- 显示光标所在行
vim.o.cursorline = true

-- 最小保留行数
vim.o.scrolloff = 10

-- 确认，比如:q因为未保存的更改失败时
-- 提供一个确认保存并退出的选项
vim.o.confirm = true
