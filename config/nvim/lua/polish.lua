-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Make popups disappear faster
vim.opt.updatetime = 300 -- Faster CursorHold events (default is 4000ms)
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (ms)

-- Configure popup menu behavior
vim.opt.pumheight = 10 -- Maximum number of items to show in popup menu
vim.opt.pumblend = 10 -- Slight transparency for popup menu

-- Close documentation windows with Escape
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "lspinfo", "man", "qf" },
  callback = function() vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true }) end,
})

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- Add keymap for opening notes.md
vim.keymap.set("n", "<leader>n", ":e ~/notes.md<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
