require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({})

require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "stylua",
    "luacheck",
    "pyright",
    "ruff",
    "clang-format",
  },
  auto_update = false,
  integrations = {
    ["mason-lspconfig"] = true,
  },
})
