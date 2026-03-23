return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { '<C-b>', '<Cmd>Neotree toggle<CR>', desc = 'Toggle Neo-tree' },
    },
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["<C-b>"] = "close_window",
                },
            },
            filesystem = {
                hijack_netrw_behavior = "disabled",
                follow_current_file = {
                    enabled = true,
                },
            }
        })
    end
}
