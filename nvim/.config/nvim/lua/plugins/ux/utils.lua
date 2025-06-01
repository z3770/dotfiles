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
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>c", group = "LSP/Code" },
        { "<leader>f", group = "Fzf" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>n", group = "Noice" },
        { "<leader>u", group = "UI" },
        { "<leader>x", group = "Trouble" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
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
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      -- Resizing splits
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
      -- Move between splits
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
