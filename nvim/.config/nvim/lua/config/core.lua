local set = vim.opt

set.nu = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.smartindent = true
set.wrap = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.scrolloff = 8
set.signcolumn = "yes"

set.termguicolors = true
set.cursorline = false
set.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text when yanking",
  callback = function()
    vim.highlight.on_yank()
  end,
})
