-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.quarto" },
  { import = "astrocommunity.motion.flash-nvim" },
  -- { import = "astrocommunity.completion.copilot-cmp" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.pack.html-css" },
  -- { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.quarto" },
  -- { import = "astrocommunity.themes.nord" },
  -- import/override with your plugins folder
}
