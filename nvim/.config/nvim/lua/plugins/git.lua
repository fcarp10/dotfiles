return {
  {
    "esmuellert/codediff.nvim",
    -- Newer releases changed the view API used by Neogit's integration.
    tag = "v2.49.2",
    cmd = "CodeDiff",
    opts = {
      diff = { layout = "side-by-side" },
      explorer = { view_mode = "tree", auto_refresh = true },
    },
    keys = {
      { "<leader>gv", "<cmd>CodeDiff<cr>", desc = "Git Changes (CodeDiff)" },
      { "<leader>gV", "<cmd>CodeDiff file HEAD<cr>", desc = "Git Diff Current File (CodeDiff)" },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "esmuellert/codediff.nvim",
      "folke/snacks.nvim",
    },
    opts = {
      kind = "tab",
      diff_viewer = "codediff",
      integrations = {
        codediff = true,
        diffview = false,
        snacks = true,
      },
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Git Status (Neogit)" },
    },
  },
}
