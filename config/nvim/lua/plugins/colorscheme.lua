return {
  -- Add Gruvbox Material colorscheme
  {
    "sainnhe/gruvbox-material",
    priority = 1000, -- Load before other plugins
    init = function()
      -- Configure Gruvbox Material options before colorscheme loads
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "dim"  -- Make floating windows look distinct
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
    end,
    config = function()
      -- Set colorscheme after options
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
}
