return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = false, -- Use a classic bottom cmdline for search
          command_palette = false, -- Position the cmdline and popupmenu together
          long_message_to_split = true, -- Long messages will be sent to a split
          inc_rename = true, -- Enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- Add a border to hover docs and signature help
        },
      }
    end,
    keys = {
      {
        "<leader><leader>m",
        "<cmd>Noice all<cr>",
        mode = { "n", "v" },
        desc = "Show messages",
      },
    },
  },
}
