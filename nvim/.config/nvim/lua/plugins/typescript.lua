return {
  -- Install language servers and tools via Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "vtsls",                        -- TypeScript/JavaScript LSP (better than ts_ls)
        "tailwindcss-language-server",  -- TailwindCSS support
        "eslint-lsp",                   -- ESLint support
        "prettierd",                    -- Code formatter (prettier daemon)
      },
    },
  },

  -- Configure TypeScript/JavaScript LSP with vtsls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          enabled = true,
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            typescript = {
              -- Auto-update imports when files move
              updateImportsOnFileMove = { enabled = "always" },
              -- Enable smart completions
              suggest = {
                completeFunctionCalls = true,
                autoImports = true,              -- Enable auto-import suggestions
              },
              -- Inline type hints
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              -- Import settings
              imports = {
                enabled = true,                  -- Enable import handling
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
                autoImports = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          init_options = {
            preferences = {
              -- Use es6 imports instead of commonjs
              importModuleSpecifierPreference = "shortest",
              -- Quote style preference
              quotePreference = "single",
            },
          },
        },
        -- TailwindCSS language server
        tailwindcss = {
          enabled = true,
          filetypes = {
            "html",
            "css",
            "jsx",
            "tsx",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "twMerge\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        -- ESLint language server
        eslint = {
          enabled = true,
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
          settings = {
            eslint = {
              experimental = {
                useFlatConfig = true,
              },
              useFlatConfig = true,
              workingDirectories = { mode = "auto" },
              validate = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
              },
            },
          },
        },
        -- Disable conflicting TypeScript servers
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
      },
    },
  },

  -- Configure formatting with prettier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

}
