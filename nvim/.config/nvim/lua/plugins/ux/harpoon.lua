return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup {}
      local harpoon = require "harpoon"
      local map = vim.keymap.set
      map("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Append" })

      map("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: List " })

      for i = 1, 9 do
        map("n", "<leader>" .. i, function()
          harpoon:list():select(i)
        end, { desc = "Harpoon to file" .. i })
      end
    end,
  },
}
