return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {},
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Rendering" },
    },
  },
  {
    "folke/snacks.nvim",
    init = function()
      -- Keep inline images, but do not render fenced Mermaid/math diagrams.
      vim.treesitter.query.set("markdown", "images", "")
    end,
    opts = {
      image = {
        enabled = true,
        math = { enabled = false },
      },
    },
  },
}
