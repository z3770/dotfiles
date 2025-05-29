return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux Navigate Left" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux Navigate Down" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux Navigate Up" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux Navigate Right" },
  },
}
