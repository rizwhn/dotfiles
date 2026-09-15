return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview Toggle",
        ft = "markdown",
      },
    },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        disable_filename = 0,
      }
    end,
  },

  -- render-markdown.nvim for in-buffer rendering
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   opts = {},
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- },
}
