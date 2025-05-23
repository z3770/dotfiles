require("catppuccin").setup({
  flavour = "macchiato", -- mocha, macchiato, frappe, latte
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    noice = true,
    telescope = true,
    which_key = true,
  },
})
vim.cmd("colorscheme catppuccin")
