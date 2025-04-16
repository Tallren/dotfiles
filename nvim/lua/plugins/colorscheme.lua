return {
  -- add gruvbox
  {
  "phha/zenburn.nvim",
  lazy = false,
  priority = 1000,
  config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme zenburn]])
    end,
  },
}
