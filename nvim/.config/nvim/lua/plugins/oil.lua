return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = { view_options = {
    show_hidden = true,
  } },
  keys = {
    {
      "<leader>fe",
      function()
        require("oil").open(LazyVim.root())
      end,
      desc = "Explorer Oil (root dir)",
    },
    {
      "<leader>fE",
      function()
        require("oil").open()
      end,
      desc = "Explorer Oil (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Oil (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer Oil (cwd)", remap = true },
  },
}
