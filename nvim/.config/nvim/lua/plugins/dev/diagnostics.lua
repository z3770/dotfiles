return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    use_diagnostic_signs = true,
  },
  keys = {
    {
      "<leader>dt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Toggle Trouble",
    },
  },
}
