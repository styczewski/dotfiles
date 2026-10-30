-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Wstawianie wersetu biblijnego z bazy SQLite za pomocą skrótu <leader>bv
vim.keymap.set("n", "<leader>bv", function()
  require("config.bible").insert_bible_verse()
end, { desc = "Wstaw werset z Biblii" })

-- ==========================================
-- 1. Easy line wrapping (Zawijanie akapitów)
-- ==========================================
-- W trybie Insert (gq) - przełącza tymczasowo ft na markdown, formatuje i wraca do insert
vim.keymap.set("i", "gq", "<Esc>:set ft=<CR>gw}:set ft=markdown<CR>0A", { desc = "Format line wrapping (Insert)" })

-- W trybie Normal (<leader>gq) - formatuje cały wizualny akapit (vip) za pomocą gq
vim.keymap.set("n", "<leader>gq", "vipgq", { desc = "Format paragraph wrapping (Normal)" })

-- ==========================================
-- 2. Przesuwanie linii i dodawanie nowych (Ctrl + hjkl)
-- ==========================================
-- Używamy tabeli {"n", "x"} zamiast stringa "nx"
vim.keymap.set({ "n", "x" }, "<C-k>", "ddkP", { desc = "Przesuń linię w górę" })
vim.keymap.set({ "n", "x" }, "<C-j>", "ddp", { desc = "Przesuń linię w dół" })

-- Dodawanie nowej pustej linii nad / pod kursorem
vim.keymap.set({ "n", "x" }, "<C-l>", "o<ESC>k", { desc = "Dodaj pustą linię pod spodem" })
vim.keymap.set({ "n", "x" }, "<C-h>", "O<ESC>j", { desc = "Dodaj pustą linię nad kurserem" })


-- ==========================================
-- 3. Zwiększanie / zmniejszanie wcięcia powtarzane kropką (.)
-- ==========================================
-- Używamy wtyczki repeat (wbudowanej w ekosystem lazy) lub czystego mapowania operatorów:
vim.keymap.set("n", ">", ">>", { desc = "Zwiększ wcięcie" })
vim.keymap.set("n", "<", "<<", { desc = "Zmniejsz wcięcie" })

-- W trybie Visual powtarzanie kropką zachowuje zaznaczenie i pozwala na wielokrotne wciskanie '.'
vim.keymap.set("x", ">", ">gv", { desc = "Zwiększ wcięcie i zachowaj zaznaczenie" })
vim.keymap.set("x", "<", "<gv", { desc = "Zmniejsz wcięcie i zachowaj zaznaczenie" })

-- Zamiana miejscami klawiszy ; oraz :
-- Średnik otwiera linię poleceń (zastępuje :)
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "CMD mode" })

-- Dwukropek powtarza ostatnie wyszukiwanie znaku f/t (zastępuje ;)
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Repeat find (f/t)" })

local function surround_visual(start_tag, end_tag)
  -- 1. Przywrócenie zaznaczenia, aby pobrać jego współrzędne
  vim.cmd('normal! gv')

  local _, srow, scol, _ = unpack(vim.fn.getpos("'<"))
  local _, erow, ecol, _ = unpack(vim.fn.getpos("'>"))

  if srow > erow or (srow == erow and scol > ecol) then
    srow, erow = erow, srow
    scol, ecol = ecol, ecol
  end

  local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
  if #lines == 0 then return end

  -- 2. Dodajemy spacje wewnątrz tagów: np. ">R " oraz " R<"
  local padded_start = start_tag .. " "
  local padded_end = " " .. end_tag

  if #lines == 1 then
    local line = lines[1]
    lines[1] = line:sub(1, scol - 1) .. padded_start .. line:sub(scol, ecol) .. padded_end .. line:sub(ecol + 1)
  else
    lines[1] = lines[1]:sub(1, scol - 1) .. padded_start .. lines[1]:sub(scol)
    lines[#lines] = lines[#lines]:sub(1, ecol) .. padded_end .. lines[#lines]:sub(ecol + 1)
  end

  vim.api.nvim_buf_set_lines(0, srow - 1, erow, false, lines)

  -- 3. Wyjście z trybu wizualnego do normalnego i ustawienie kursora na końcu wstawionego tagu
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  vim.api.nvim_win_set_cursor(0, { erow, ecol + #padded_start + #padded_end })
end

-- Używamy bezpiecznego prefiksu "gh" (lub np. "<leader>h") w trybie Visual (x):
vim.keymap.set("x", "ghr", function() surround_visual(">R", "R<") end, { desc = "Zakreśl czerwonym (tekst)" })
vim.keymap.set("x", "ghb", function() surround_visual(">B", "B<") end, { desc = "Zakreśl niebieskim (tekst)" })
vim.keymap.set("x", "ghg", function() surround_visual(">G", "G<") end, { desc = "Zakreśl zielonym (tekst)" })
vim.keymap.set("x", "ghy", function() surround_visual(">Y", "Y<") end, { desc = "Zakreśl żółtym (tekst)" })
vim.keymap.set("x", "ghp", function() surround_visual(">P", "P<") end, { desc = "Zakreśl różowym (tekst)" })
vim.keymap.set("x", "gho", function() surround_visual(">O", "O<") end, { desc = "Zakreśl pomarańczowym (tekst)" })

-- Wersje z tłem (>tR ... Rt<)
vim.keymap.set("x", "ghtr", function() surround_visual(">tR", "Rt<") end, { desc = "Zakreśl czerwonym (tło)" })
vim.keymap.set("x", "ghtb", function() surround_visual(">tB", "Bt<") end, { desc = "Zakreśl niebieskim (tło)" })
vim.keymap.set("x", "ghtg", function() surround_visual(">tG", "Gt<") end, { desc = "Zakreśl zielonym (tło)" })
vim.keymap.set("x", "ghty", function() surround_visual(">tY", "Yt<") end, { desc = "Zakreśl żółtym (tło)" })
vim.keymap.set("x", "ghtp", function() surround_visual(">tP", "Pt<") end, { desc = "Zakreśl różowym (tło)" })
vim.keymap.set("x", "ghto", function() surround_visual(">tO", "Ot<") end, { desc = "Zakreśl pomarańczowym (tło)" })
