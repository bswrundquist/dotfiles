return {
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup({
        -- Add custom surrounds
        surrounds = {
          -- Add any custom surrounds here
        },
        -- Customize the behavior
        mappings = {
          add = "sa", -- Add surrounding in Normal and Visual modes
          delete = "sd", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "su", -- Update `n_lines`
          visual = "sv", -- Visual mode
        },
      })
    end,
  },
} 