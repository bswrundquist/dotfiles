return {
  "kevinhwang91/nvim-bqf",
  event = { "BufRead", "BufNew" },
  config = function()
    require("bqf").setup({
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 22,
        win_vheight = 22,
        delay_syntax = 80,
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
        show_title = false,
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match(".tex$") or bufname:match(".md$") then
            -- skip markdown and latex files
            ret = false
          end
          return ret
        end,
      },
      func_map = {
        open = "<CR>",
        openc = "o",
        drop = "O",
        split = "<C-s>",
        vsplit = "<C-v>",
        tab = "t",
        tabb = "T",
        tabc = "<C-t>",
        prev = "p",
        next = "n",
        pscroll = "<C-d>",
        nscroll = "<C-u>",
        pfile = "[",
        nfile = "]",
        ptab = "{",
        ntab = "}",
        helpgrp = "<F1>",
      },
    })
  end,
}
