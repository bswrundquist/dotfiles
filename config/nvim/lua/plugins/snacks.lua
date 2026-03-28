return {
  {
    "folke/snacks.nvim",
    opts = {
      gitbrowse = {},
      image = {},
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████",
            " ",
            "    ███    ██ ██    ██ ██ ███    ███",
            "    ████   ██ ██    ██ ██ ████  ████",
            "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
            "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
            "    ██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
    keys = {
      {
        "<leader>gY",
        function()
          require("snacks").gitbrowse({
            open = function(url) vim.fn.setreg("+", url) end,
            notify = false,
          })
        end,
        mode = { "n", "x" },
        desc = "Git Browse (copy)",
      },
    },
  },
}
