return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	keys = {
		{ "<leader>pf", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }, path_display = { 'truncate'} })<cr>", desc = "Find Files" },
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		{ "<leader>pt", "<cmd>lua require'telescope.builtin'.live_grep({ path_display = { 'truncate'} })<cr>", desc = "Find Text" },
	},
	dependencies = { 'nvim-lua/plenary.nvim' }
}
