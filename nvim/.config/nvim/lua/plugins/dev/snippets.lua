return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  lazy = true,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
  dependencies = { "rafamadriz/friendly-snippets", lazy = true },
}
