return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = {
      indent = {
        enabled = false,
      },
      chunk = {
        enabled = true,
        char = {
          horizontal = '─',
          vertical = '│',
          corner_top = '╭',
          corner_bottom = '╰',
          arrow = '─',
        },
      },
    },
    input = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
  },
}
