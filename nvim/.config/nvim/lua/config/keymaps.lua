-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LSP navigation keymaps
-- local map = vim.keymap.set
-- local lsp = vim.lsp.buf
--
-- map("n", "gd", lsp.definition, { noremap = true, silent = true, desc = "Go to definition" })
-- map("n", "gi", lsp.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
-- map("n", "gr", lsp.references, { noremap = true, silent = true, desc = "Find references" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy relative file path to clipboard
vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { noremap = true, silent = true, desc = "Copy relative file path to clipboard" })

-- Register LSP keymaps when servers attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    if not args or not args.buf or not args.data then
      return
    end

    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = buffer, noremap = true, silent = true, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to Definition")
    map("gr", vim.lsp.buf.references, "Find References")
    map("gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  end,
})