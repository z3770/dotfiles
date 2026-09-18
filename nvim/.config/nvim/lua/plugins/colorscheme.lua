return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      -- `transparent` doesn't cover the statusline: tokyonight keeps
      -- bg_statusline here, and statusline cells inherit it as their base bg.
      on_highlights = function(hl, c)
        hl.StatusLine = { fg = c.fg_sidebar, bg = c.none }
        hl.StatusLineNC = { fg = c.fg_gutter, bg = c.none }
      end,
    },
  },

  { "catppuccin/nvim", name = "catppuccin", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
