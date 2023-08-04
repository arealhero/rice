local keyset = vim.keymap.set

keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

keyset("i", "<C-j>", [[coc#pum#visible() ? coc#pum#confirm() : coc#refresh()]], {silent = true, expr = true})
keyset("i", "<C-space>", "coc#refresh()", {silent = true, expr = true})

vim.cmd[[
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
]]

