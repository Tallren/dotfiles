require('scripts')
require('lazy').setup('plugins')
require('lsp_setup')
vim.cmd.colorscheme "catppuccin-frappe"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.go.syntax = "on"
vim.go.tabstop = 4
vim.go.shiftwidth = 4
vim.go.expandtab = true
vim.g.netrw_banner = 0

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '❌',
      [vim.diagnostic.severity.WARN]  = '⚠️',
      [vim.diagnostic.severity.HINT]  = '💡',
      [vim.diagnostic.severity.INFO]  = 'ℹ️',
    },
  },
})

-- Resize splits
vim.keymap.set('n', '<C-H>', '<C-W><')
vim.keymap.set('n', '<C-L>', '<C-W>>')
vim.keymap.set('n', '<C-K>', '<C-W>+')
vim.keymap.set('n', '<C-J>', '<C-W>-')

