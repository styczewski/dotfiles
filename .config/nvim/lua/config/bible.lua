local M = {}

function M.insert_bible_verse()
  local db_path = "/storage/doku/db/biblie.db"

  -- 1. Pobranie unikalnej listy ksiąg z bazy danych
  local cmd_books = string.format("sqlite3 %s %s", vim.fn.shellescape(db_path), vim.fn.shellescape("SELECT DISTINCT ksiega FROM biblia_nwt;"))
  local handle_books = io.popen(cmd_books)
  if not handle_books then return end
  local result_books = handle_books:read("*a")
  handle_books:close()

  if not result_books or result_books == "" then
    vim.notify("Brak ksiąg w bazie danych!", vim.log.levels.ERROR)
    return
  end

  local books = {}
  for line in result_books:gmatch("[^\r\n]+") do
    if line ~= "" then
      table.insert(books, line)
    end
  end

  -- 2. Wybór księgi
  vim.ui.select(books, {
    prompt = "Wybierz księgę Biblii:",
    format_item = function(item)
      return item
    end,
  }, function(selected_book)
    if not selected_book then return end

    -- 3. Prompt na podanie rozdziału i wersetu
    vim.ui.input({ prompt = "Podaj rozdział:werset (np. 3:16 lub 6:7-8 dla " .. selected_book .. "): " }, function(input)
      if not input or input == "" then return end

      local chap, v_start, v_end = input:match("^(%d+):(%d+)%-?(%d*)$")

      if not chap or not v_start then
        vim.notify("Niepoprawny format! Użyj np.: '3:16' lub '1:1-5'", vim.log.levels.ERROR)
        return
      end

      chap = tonumber(chap)
      v_start = tonumber(v_start)
      v_end = (v_end ~= "" and tonumber(v_end)) or v_start

      -- 4. Zapytanie SQL
      local sql_query = string.format(
        "SELECT ksiega, rozdzial, werset, tresc FROM biblia_nwt WHERE ksiega = '%s' AND rozdzial = %d AND werset BETWEEN %d AND %d ORDER BY werset ASC;",
        selected_book, chap, v_start, v_end
      )

      local cmd = string.format("sqlite3 %s %s", vim.fn.shellescape(db_path), vim.fn.shellescape(sql_query))
      local handle = io.popen(cmd)
      if not handle then return end

      local result = handle:read("*a")
      handle:close()

      if not result or result == "" then
        vim.notify("Nie znaleziono wersetów dla: " .. selected_book .. " " .. input, vim.log.levels.WARN)
        return
      end

      -- 5. Budowanie nagłówka (np. "1Tym 6:7-8" lub "1Tym 6:7" przy pojedynczym wierszu)
      local header
      if v_start == v_end then
        header = string.format("%s %d:%d", selected_book, chap, v_start)
      else
        header = string.format("%s %d:%d-%d", selected_book, chap, v_start, v_end)
      end

      -- 6. Łączenie wersetów w jedną linię: (7) treść... (8) treść...
      local verse_parts = {}
      for line in result:gmatch("[^\r\n]+") do
        local _, _, v, text = line:match("^(.-)|(.-)|(.-)|(.*)$")
        if text then
          table.insert(verse_parts, string.format("(%s) %s", v, text))
        end
      end
      local content_line = table.concat(verse_parts, " ")

      -- 7. Wstawienie dwóch linii do bufora Neovima
      local lines = { header, content_line }
      local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
      vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    end)
  end)
end

return M
