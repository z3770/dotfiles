return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
config = function()
    require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "python",
    "cpp",
    "bash",
    "json",
    "yaml",
    "markdown",
    "vim",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  autotag = {
    enable = false,
  },
})

end,
},
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    config = function()
        require("treesitter-context").setup({
          enable = true,
          max_lines = 3,
          trim_scope = "outer",
          min_window_height = 10,
          multiline_threshold = 1,
          mode = "cursor",
          separator = nil,
          zindex = 20,
})
end,
  },
}
