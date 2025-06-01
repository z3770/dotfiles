return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    files = {
      file_icons = "mini",
    },
    keymap = {
      builtin = {
        true,
        ["g?"] = "toggle-help",
        ["<C-S-j>"] = "preview-down",
        ["<C-S-k>"] = "preview-up",
      },
    },
  },
  keys = {
    {
      "<leader>ff",
      "<cmd>FzfLua files<cr>",
      desc = "Find Files",
    },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find Buffers" },
    {
      "<leader>fh",
      "<cmd>FzfLua helptags<cr>",
      desc = "Find help_tags",
    },
  },
}
