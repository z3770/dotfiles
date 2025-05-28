-- Base vim settings
vim.opt.number = true -- Show row numbers
vim.opt.relativenumber = true -- Show relative row numbers
vim.opt.expandtab = true -- Spaces instead of tab
vim.opt.tabstop = 4 -- Number of spaces instead of 'Tab'
vim.opt.shiftwidth = 4 -- Autoindent
vim.opt.smartindent = true -- Smart indent
vim.opt.wrap = false -- Wrap strings
vim.opt.termguicolors = true -- True colors
vim.opt.cursorline = true -- Highlight cursor line
vim.g.mapleader = " " -- Set leader key
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.wrap = true

-- Diagnostics config
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
  float = {
    border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow", "none"
    source = "if_many",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
