return {
  "404pilo/aicommits.nvim",
  config = function()
    require("aicommits").setup({
      active_provider = "gemini-api",
      ui: {
        use_custom_picker = true,
        picker = {
          width = 0.4,             -- Percentage of screen width
          height = 0.3,            -- Percentage of screen height
          border = "rounded",      -- Border style
        },
      },
      providers = {
        ["gemini-api"] = {
          enabled = true,
          model = "gemini-2.5-flash",
          max_length = 200,
          temperature = 0.8,
          max_tokens = 500,
          generate = 3,
        },
      },
      integrations = {
        neogit = {
          enabled = false, -- Disable the warning
        },
      },
    })
  end,
}
