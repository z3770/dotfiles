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
