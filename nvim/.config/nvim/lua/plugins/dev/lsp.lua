return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            {
              path = "${3rd}/luv/library",
              words = { "vim%.uv" },
            },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.enable { "lua_ls", "basedpyright", "ruff" }

      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        offset_encoding = "utf-8",
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspaces",
            },
          },
        },
      })
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
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function()
      require("mason").setup {}
    end,
  },
}
