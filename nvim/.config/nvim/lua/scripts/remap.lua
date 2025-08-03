vim.g.mapleader = " "
vim.keymap.set({'i'}, 'jh', '<Esc>', { noremap = true})
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '+p')
vim.keymap.set('n', '<leader>fu', vim.lsp.buf.references)
