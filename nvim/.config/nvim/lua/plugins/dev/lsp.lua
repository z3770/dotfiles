return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            {
              path = "${3rd}/luv/library",
              words = { "vim%.uv" },
            },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup {}
      lspconfig.pyright.setup {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      }
      lspconfig.ruff.setup {}
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format" },
          json = { "jq" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      }
    end,
    keys = {
      {
        "grf",
        function()
          require("conform").format {
            async = true,
            lsp_fallback = true,
          }
        end,
        desc = "Format",
      },
    },
  },
}
