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
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
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
        { "<leader>d", group = "Debug", icon = "󰃤" },
        { "<leader>f", group = "Fzf", icon = "󱡠" },
        { "<leader>h", group = "Harpoon", icon = "󱡀" },
        { "<leader><leader>", group = "Other" },
        { "<leader>x", group = "Trouble", icon = "󰙅" },
        { "<leader>u", group = "Undotree", icon = "󰙅" },
        { "<leader>z", group = "Zen", icon = "Z" },
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
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      {
        "<C-S-h>",
        "<cmd>SmartResizeLeft<cr>",
        desc = "Smart Splits: Resize left",
      },
      {
        "<C-S-j>",
        "<cmd>SmartResizeDown<cr>",
        desc = "Smart Splits: Resize down",
      },
      {
        "<C-S-k>",
        "<cmd>SmartResizeUp<cr>",
        desc = "Smart Splits: Resize up",
      },
      {
        "<C-S-l>",
        "<cmd>SmartResizeRight<cr>",
        desc = "Smart Splits: Resize Right",
      },
      {
        "<C-h>",
        "<cmd>SmartCursorMoveLeft<cr>",
        desc = "Smart Splits: Move left",
      },
      {
        "<C-j>",
        "<cmd>SmartCursorMoveDown<cr>",
        desc = "Smart Splits: Move down",
      },
      {
        "<C-k>",
        "<cmd>SmartCursorMoveUp<cr>",
        desc = "Smart Splits: Move up",
      },
      {
        "<C-l>",
        "<cmd>SmartCursorMoveRight<cr>",
        desc = "Smart Splits: Move right",
      },
    },
  },
}
