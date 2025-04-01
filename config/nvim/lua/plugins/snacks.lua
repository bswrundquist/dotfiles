return {
  {
    "folke/snacks.nvim",
    opts = {
      gitbrowse = {
        -- minimal configuration with default settings
      },
      images = {
        -- minimal configuration with default settings
      }
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      vim.keymap.set(
        {"n", "x"},
        "<leader>gY",
        function()
          require("snacks").gitbrowse({
            open = function(url)
              vim.fn.setreg("+", url)
            end,
            notify = false
          })
        end,
        { desc = "Git Browse (copy)" }
      )
    end
  }
} 