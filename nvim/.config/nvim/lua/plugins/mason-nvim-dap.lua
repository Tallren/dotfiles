return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  opts = {
    automatic_installation = true,

    -- Skip codelldb since we configure it manually in nvim-dap.lua
    handlers = {
      function(config)
        -- Default handler - auto-setup all adapters
        require('mason-nvim-dap').default_setup(config)
      end,
      codelldb = function(config)
        -- Skip codelldb - we configure it manually
      end,
    },

    ensure_installed = {
      'js',
      'codelldb', -- Install it but don't auto-configure
    },
  }
}
