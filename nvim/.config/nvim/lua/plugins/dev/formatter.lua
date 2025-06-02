return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        cpp = { "clang-format" },
        json = { "jq" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
  keys = {
    {
      "grf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Code format",
    },
  },
}
