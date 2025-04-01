return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true,
        },
      })
      
      -- Key mappings for neogit
      local neogit = require("neogit")
      vim.keymap.set("n", "<leader>gnn", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
      vim.keymap.set("n", "<leader>gnc", "<cmd>NeogitCommit<CR>", { desc = "Neogit commit" })
      vim.keymap.set("n", "<leader>gnd", "<cmd>lua require('neogit').action('diff', 'staged')()<CR>", { desc = "Neogit diff" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
} 