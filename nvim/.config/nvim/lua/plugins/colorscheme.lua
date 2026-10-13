return {
  -- Disable themes bundled with LazyVim.
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "Shatur/neovim-ayu",
    lazy = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu-dark",
    },
  },
}
