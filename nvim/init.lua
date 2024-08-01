require('scripts')
require("lazy").setup("plugins")
vim.wo.number = true
vim.wo.wrap = false
vim.wo.relativenumber = true
vim.go.syntax = "on"
vim.go.tabstop = 4
vim.go.shiftwidth = 4
vim.go.expandtab = true

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- https://lsp-zero.netlify.app/v3.x/language-server-configuration.html
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]})

-- here you can setup the language servers
-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
	  "clangd",
	  "lua_ls",
	  "pylsp",
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

