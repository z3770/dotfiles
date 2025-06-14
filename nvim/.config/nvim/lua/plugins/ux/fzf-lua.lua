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
        ["<C-d>"] = "preview-down",
        ["<C-u>"] = "preview-up",
      },
    },
  },
  keys = {
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find Buffers" },
    {
      "<leader>fc",
      function()
        require("fzf-lua").files { cwd = vim.fn.stdpath "config" }
      end,
      desc = "Neovim config",
    },
    {
      "<leader>ff",
      "<cmd>FzfLua files<cr>",
      desc = "Find Files",
    },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
    {
      "<leader>fh",
      "<cmd>FzfLua helptags<cr>",
      desc = "Find help_tags",
    },
  },
}
