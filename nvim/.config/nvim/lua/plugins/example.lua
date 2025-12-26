-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
 -- add gruvbox
 -- { "ellisonleao/gruvbox.nvim" },
 --
 -- -- Configure LazyVim to load gruvbox
 -- {
 --   "LazyVim/LazyVim",
 --   opts = {
 --     colorscheme = "gruvbox",
 --   },
 -- },
 --
 -- Diagnostics viewer: unified panel for LSP errors, warnings, and info across the project
 -- see all errors by using <leader>xx
 {
  "folke/trouble.nvim",
  enabled = true, --disable trouble if needed
  opts = { use_diagnostic_signs = true },
 },

 -- change some telescope options and a keymap to browse plugin files
 {
  "nvim-telescope/telescope.nvim",
  keys = {
   {
	"<leader>fp",
	function()
	 require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
	end,
	desc = "Find Plugin File",
   },
  },
  opts = {
   defaults = {
	layout_strategy = "horizontal",
	layout_config = { prompt_position = "top" },
	sorting_strategy = "ascending",
	winblend = 1,
	hidden = true,
	hide_gitignored = false,
   },
  },
 },

 -- add pyright to lspconfig
 {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
   ---@type lspconfig.options
   servers = {
	pyright = {},
   },
  },
 },

 -- extend treesitter with Go parsers
 {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
   vim.list_extend(opts.ensure_installed, {
	"go",
	"gomod",
	"gosum",
   })
  end,
 },

 -- lualine customization
 {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
   table.insert(opts.sections.lualine_x, {
	function()
	 return "😄"
	end,
   })
  end,
 },

 -- add tools to mason
 {
  "mason-org/mason.nvim",
  opts = {
   ensure_installed = {
	"stylua",
	"shellcheck",
	"shfmt",
	"flake8",
	"golangci-lint",
	"gopls",
	"typescript-language-server",
   },
  },
 },
}
