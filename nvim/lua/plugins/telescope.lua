return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	keys = {
		{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		{
		  "<leader>fp",
		  function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ")}) end,
		  desc = "Find Plugin File"
		}
	},
	dependencies = { 'nvim-lua/plenary.nvim' }
}
