local function lsp_name()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    return "  " .. clients[1].name
  else
    return ""
  end
end

local function clock()
  return "🕒 " .. os.date("%H:%M")
end

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
    icons_enabled = true,
    disabled_filetypes = {
      statusline = { "NvimTree" },
      winbar = {},
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
        colored = true,
        source = nil,
      },
    },
    lualine_c = {},
    lualine_x = { "filetype" },
    lualine_y = { lsp_name, "location" },
    lualine_z = { clock },
  },
})
