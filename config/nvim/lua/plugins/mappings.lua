return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>nb"] = { "<cmd>e ~/.notebook/notes.md<cr>", desc = "Open notes" },
          ["<Leader>nr"] = { "<cmd>e ~/.notebook/rolodex.md<cr>", desc = "Open rolodex" },
          ["<Leader>nt"] = { "<cmd>e ~/.notebook/tasks.md<cr>", desc = "Open tasks" },
          ["<Leader>na"] = { "<cmd>e ~/.notebook/admin.md<cr>", desc = "Open admin" },
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          ["<Leader>z"] = { "<cmd>:ZenMode<cr>" },
          -- Capital H and L to navigate to beginning/end of line
          ["H"] = { "^", desc = "Go to beginning of line" },
          ["L"] = { "$", desc = "Go to end of line" },
          -- quickfix list navigation with Ctrl+Shift+j/k/l
          ["<C-S-j>"] = { "<cmd>try | cnext | catch | cfirst | catch | endtry<cr>", desc = "Next quickfix item" },
          ["<C-S-k>"] = { "<cmd>try | cprev | catch | clast | catch | endtry<cr>", desc = "Previous quickfix item" },
          ["<C-S-l>"] = { "<cmd>copen<cr>", desc = "Open quickfix list" },
          ["<C-S-h>"] = { "<cmd>cclose<cr>", desc = "Close quickfix list" },
          -- Search for visually selected text in project and put in quickfix list
          ["<C-S-i>"] = {
            function()
              local escaped_text = vim.fn.escape(vim.fn.expand "<cword>", "\\/.*$^~[]")
              vim.cmd("vimgrep /" .. escaped_text .. "/gj **/*")
              vim.cmd "copen"
            end,
            desc = "Find word under cursor in project",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        i = {
          ["kj"] = { "<esc>", desc = "Exit insert mode" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
