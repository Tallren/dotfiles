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
      "helm_ls",
      "jdtls",
      "rust_analyzer"
    },
    handlers = {
    function(server_name)
        if server_name == 'tsserver' then
            server_name = 'ts_ls'
        end
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server_name].setup({
            capabilities = capabilities
        })
    end,

    ts_ls = function()
        require('lspconfig').ts_ls.setup({
            on_attach = function (client, bufnr)
            end
        })
    end,
    jdtls = function()
        -- Skipping auto-setup, configured separately in ftplugin/java.lua
    end
    },
})
local extension_path = vim.fn.stdpath("data")
    .. "/mason/packages/sonarlint-language-server/extension"

require("sonarqube").setup({
    lsp = {
        cmd = {
            vim.fn.exepath("java"),
            "-jar",
            extension_path .. "/server/sonarlint-ls.jar",
            "-stdio",
            "-analyzers",
            extension_path .. "/analyzers/sonargo.jar",
            extension_path .. "/analyzers/sonarhtml.jar",
            extension_path .. "/analyzers/sonariac.jar",
            extension_path .. "/analyzers/sonarjava.jar",
            extension_path .. "/analyzers/sonarjavasymbolicexecution.jar",
            extension_path .. "/analyzers/sonarjs.jar",
            extension_path .. "/analyzers/sonarphp.jar",
            extension_path .. "/analyzers/sonarpython.jar",
            extension_path .. "/analyzers/sonartext.jar",
            extension_path .. "/analyzers/sonarxml.jar",
        },
    },
    csharp = {
        enabled = true,
        omnisharpDirectory = extension_path .. "/omnisharp",
        csharpOssPath = extension_path .. "/analyzers/sonarcsharp.jar",
        csharpEnterprisePath = extension_path .. "/analyzers/csharpenterprise.jar",
    },
})

