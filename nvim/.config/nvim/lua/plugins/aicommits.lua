return {
  "404pilo/aicommits.nvim",
  config = function()
    require("aicommits").setup({
      active_provider = "openai",
      ui = {
        use_custom_picker = true,
        picker = {
          width = 0.4, -- Percentage of screen width
          height = 0.3, -- Percentage of screen height
          border = "rounded", -- Border style
        },
      },
      providers = {
        ["gemini-api"] = {
          enabled = false,
          model = "gemini-2.5-flash",
          max_length = 200,
          temperature = 0.8,
          max_tokens = 500,
          generate = 3,
        },
        ["openai"] = {
          enabled = true,
          endpoint = "http://localhost:11434/v1/chat/completions",
          model = "gemma2:2b",
          max_length = 200,
          temperature = 0.7,
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
