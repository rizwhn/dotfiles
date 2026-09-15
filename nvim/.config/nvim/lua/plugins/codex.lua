return {
  "johnseth97/codex.nvim",
  lazy = true,
  cmd = { "Codex", "CodexToggle" },
  keys = {
    {
      "<C-x>",
      function()
        require("codex").toggle()
      end,
      desc = "Toggle Codex popup or side-panel",
      mode = { "n", "i" },
    },
  },
  opts = {
    keymaps = {
      toggle = nil,
      quit = "<C-q>",
    },
    border = "rounded",
    width = 0.8,
    height = 0.8,
    model = nil,
    autoinstall = false,
    panel = false,
    use_buffer = false,
  },
}
