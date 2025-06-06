return {

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = true,
    keys = {
      {
        "<leader>ut",
        "<cmd>TransparentToggle<cr>",
        desc = "Toggle background transparency",
      },
    },
  },
}
