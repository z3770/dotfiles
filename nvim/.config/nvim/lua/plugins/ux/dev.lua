return {
  {
    dir = vim.fn.stdpath "config" .. "/lua/plugins/ux/present.nvim/",
    config = function()
      require "present"
    end,
  },
}
