require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
      "clangd",
      "lua_ls",
      "pyright",
      "tsserver",
      "yamlls",
      "marksman",
      "jsonls",
      "html",
      "cssls",
      "bashls"
    },
    handlers = {
    function(server_name)
    require("lspconfig")[server_name].setup({})
    end,
    },
})

