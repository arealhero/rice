local lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  -- vim.keymap.set("i", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
end

lsp.pyright.setup{
  on_attach = on_attach,
}

lsp.clangd.setup{
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>s", vim.cmd.ClangdSwitchSourceHeader, opts)
  end,
}

