return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- Show hidden files in file picker (<leader>ff, <leader><leader>)
          files = {
            hidden = true, -- show hidden files like .env
            ignored = true, -- show files ignored by git like node_modules
          },
          -- Show hidden files in sidebar explorer (<leader>e)
          explorer = {
            hidden = true, -- show hidden files like .env
            ignored = true, -- show files ignored by git like node_modules
          },
        },
      },
      terminal = {
        win = {
          position = "right",
          width = 0.25, -- 40% of screen width
        },
      },
    },
  },
}
