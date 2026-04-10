return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "sql", "lua", "vim" },
			highlight = {
				enable = true,
			},
		})
	end,
}
