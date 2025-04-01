-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.quarto" },
  -- { import = "astrocommunity.motion.flash-nvim" },
  -- { import = "astrocommunity.motion.terraform" },
  -- { import = "astrocommunity.completion.copilot-cmp" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.pack.html-css" },
  -- { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.quarto" },
  -- { import = "astrocommunity.themes.nord" },
  -- import/override with your plugins folder
  -- lazy.nvim
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
}
