vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Declaration" })

vim.keymap.set(
  "n",
  "<Tab>",
  ":bnext<CR>",
  { noremap = true, silent = true, desc = "Next buff" }
)

vim.keymap.set(
  "n",
  "<S-Tab>",
  ":bprevious<CR>",
  { noremap = true, silent = true, desc = "Prev buff" }
)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR><Esc>",
  { desc = "Remove search highlight" }
)

vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })
