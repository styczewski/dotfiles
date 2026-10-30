return {
  "bullets-vim/bullets.nvim",
  ft = { "markdown", "text", "gitcommit" }, -- ładuje wtyczkę tylko dla określonych typów plików dla oszczędności pamięci
  config = function()
    require("bullets").setup({
      -- Tutaj możesz dodać opcjonalne ustawienia, np.:
      -- cont_on_newline = true,
      -- leading_zeros = false,
      -- pill = 'o',
    })
  end,
}
