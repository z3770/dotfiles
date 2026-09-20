return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Make the middle sections transparent; tokyonight's `transparent` option
    -- doesn't cover the lualine theme, which hardcodes bg_statusline.
    local theme = require("lualine.themes.tokyonight-night")
    for name, mode in pairs(theme) do
      if mode.c then
        mode.c.bg = "NONE"
      end
      if name == "inactive" then
        mode.a.bg, mode.b.bg = "NONE", "NONE"
      end
    end
    opts.options.theme = theme

    -- Drop LazyVim's clock: the macOS menu bar already shows the time.
    opts.sections.lualine_z = {}
  end,
}
