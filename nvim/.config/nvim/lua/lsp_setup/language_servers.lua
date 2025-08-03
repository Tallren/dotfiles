require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
      "clangd",
      "lua_ls",
      "pyright",
      "ts_ls",
      "yamlls",
      "marksman",
      "jsonls",
      "html",
      "cssls",
      "bashls",
      "helm_ls"
    },
    handlers = {
    function(server_name)
        if server_name == 'tsserver' then
            server_name = 'ts_ls'
        end
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server_name].setup({
            capabilies = capabilities
        })
    end,

    ts_ls = function()
        require('lspconfig').ts_ls.setup({
            on_attach = function (client, bufnr)
            end
        })
    end
    },
})

