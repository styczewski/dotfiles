-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- 1. Definicja kolorów (możesz dopasować odcienie do swojego motywu, np. Catppuccin)
    -- Style z samym kolorem tekstu (np. >R ... R<)
    vim.api.nvim_set_hl(0, "CustomTextRed",    { fg = "#ff5555", bold = true })
    vim.api.nvim_set_hl(0, "CustomTextBlue",   { fg = "#8be9fd", bold = true })
    vim.api.nvim_set_hl(0, "CustomTextGreen",  { fg = "#50fa7b", bold = true })
    vim.api.nvim_set_hl(0, "CustomTextYellow", { fg = "#f1fa8c", bold = true })
    vim.api.nvim_set_hl(0, "CustomTextPink",   { fg = "#ff79c6", bold = true })
    vim.api.nvim_set_hl(0, "CustomTextOrange", { fg = "#ffb86c", bold = true })

    -- Style z tłem (zakreślacz, np. >tR ... Rt<)
    vim.api.nvim_set_hl(0, "CustomHiRed",    { bg = "#ff5555", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "CustomHiBlue",   { bg = "#8be9fd", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "CustomHiGreen",  { bg = "#50fa7b", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "CustomHiYellow", { bg = "#f1fa8c", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "CustomHiPink",   { bg = "#ff79c6", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "CustomHiOrange", { bg = "#ffb86c", fg = "#000000", bold = true })

    -- 2. Reguły regionów i ukrywania znaczników (Conceal)
    local highlighters = {
      { name = "textred",    start = ">R",  finish = "R<",  hl = "CustomTextRed" },
      { name = "textblue",   start = ">B",  finish = "B<",  hl = "CustomTextBlue" },
      { name = "textgreen",  start = ">G",  finish = "G<",  hl = "CustomTextGreen" },
      { name = "textyellow", start = ">Y",  finish = "Y<",  hl = "CustomTextYellow" },
      { name = "textpink",   start = ">P",  finish = "P<",  hl = "CustomTextPink" },
      { name = "textorange", start = ">O",  finish = "O<",  hl = "CustomTextOrange" },

      { name = "hired",      start = ">tR", finish = "Rt<", hl = "CustomHiRed" },
      { name = "hiblue",     start = ">tB", finish = "Bt<", hl = "CustomHiBlue" },
      { name = "higreen",    start = ">tG", finish = "Gt<", hl = "CustomHiGreen" },
      { name = "hiyellow",   start = ">tY", finish = "Yt<", hl = "CustomHiYellow" },
      { name = "hipink",     start = ">tP", finish = "Pt<", hl = "CustomHiPink" },
      { name = "hiorange",   start = ">tO", finish = "Ot<", hl = "CustomHiOrange" },
    }

    for _, h in ipairs(highlighters) do
      vim.cmd(string.format(
        "syntax region %s matchgroup=Conceal start='%s' end='%s' containedin=ALL concealends",
        h.name, h.start, h.finish
      ))
      vim.cmd(string.format("highlight link %s %s", h.name, h.hl))
    end
  end,
})

