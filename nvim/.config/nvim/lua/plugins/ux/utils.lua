return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        -- "permissions",
        -- "size",
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = { { "<C-n>", "<cmd>Oil<cr>", desc = "Open Oil" } },
  },
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader><leader>l",
        "<cmd>CellularAutomaton make_it_rain<cr>",
        desc = "F*ck My Life",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "gr", group = "LSP/Code" },
        { "grr", desc = "References" },
        { "grn", desc = "Rename" },
        { "gri", desc = "Implementation" },
        { "gra", desc = "Code actions" },
        { "<leader>d", group = "Debug", icon = { icon = "󰃤", color = "azure" } },
        { "<leader>f", group = "Fzf", icon = { icon = "󱡠", color = "blue" } },
        { "<leader>h", group = "Harpoon", icon = { icon = "󱡀", color = "orange" } },
        { "<leader>g", group = "Git", icon = { icon = "󰊢", color = "red" } },
        { "<leader><leader>", group = "Other", icon = { icon = "~", color = "cyan" } },
        { "<leader>x", group = "Trouble", icon = { icon = "󰙅", color = "green" } },
        { "<leader>u", group = "Undotree", icon = { icon = "󰙅", color = "yellow" } },
        { "<leader>z", group = "Zen", icon = { icon = "Z", color = "azure" } },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = true }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
}
