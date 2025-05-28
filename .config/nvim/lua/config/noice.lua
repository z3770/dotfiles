require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true, -- Use a classic bottom cmdline for search
    command_palette = false, -- Position the cmdline and popupmenu together
    long_message_to_split = true, -- Long messages will be sent to a split
    inc_rename = false, -- Enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- Add a border to hover docs and signature help
  },
})
