-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "bash",
      "c",
      "cpp",
      "css",
      "html",
      "javascript",
      "json",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rust",
      "tsx",
      "typescript",
      "yaml",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  build = ":TSUpdate",
}
