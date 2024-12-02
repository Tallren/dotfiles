local lsp_zero = require("lsp-zero")
local cmp = require("cmp")

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

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Enter>'] = cmp.mapping.confirm({select = true}),

        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
})

