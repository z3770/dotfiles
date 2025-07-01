return {
  {
    "saghen/blink.cmp",

    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*",

    opts = {

      keymap = {
        preset = "default",
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {

        nerd_font_variant = "mono",
      },
      signature = { enabled = true },

      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
