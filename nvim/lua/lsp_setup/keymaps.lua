local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- https://lsp-zero.netlify.app/v3.x/language-server-configuration.html
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
    vim.api.nvim_create_autocmd(
      "FileType", {
      pattern={"qf"},
      command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]})
end)

