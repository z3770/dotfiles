local map = vim.keymap.set

map("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "grD", vim.lsp.buf.declaration, { desc = "Declaration" })

map(
  "n",
  "<Tab>",
  ":bnext<CR>",
  { noremap = true, silent = true, desc = "Next buff" }
)

map(
  "n",
  "<S-Tab>",
  ":bprevious<CR>",
  { noremap = true, silent = true, desc = "Prev buff" }
)

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR><Esc>",
  { desc = "Remove search highlight" }
)

map("n", "n", "nzzzv", { noremap = true, silent = true })
map("n", "N", "Nzzzv", { noremap = true, silent = true })
