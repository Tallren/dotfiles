require('scripts')
require('lazy').setup('plugins')
require('lsp_setup')
vim.cmd.colorscheme "catppuccin-frappe"
vim.wo.number = true
vim.wo.wrap = false
vim.wo.relativenumber = true
vim.go.syntax = "on"
vim.go.tabstop = 4
vim.go.shiftwidth = 4
vim.go.expandtab = true
