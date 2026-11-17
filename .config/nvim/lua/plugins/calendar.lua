return {
  {
    "itchyny/calendar.vim",
    cmd = "Calendar",
    keys = {
      { "<leader>oc", "<cmd>Calendar<cr>", desc = "Otwórz kalendarz" },
    },
    config = function()
      -- Definiujemy globalną funkcję Vimscript wywoływaną przez calendar.vim po wciśnięciu Enter na dacie
      vim.fn['g:MyCalendarDatepicker'] = function(day, month, year, week, weekday)
        -- Formatujemy datę w Lua
        local date_table = { year = tonumber(year), month = tonumber(month), day = tonumber(day) }
        local timestamp = os.time(date_table)

        -- Definiujemy dostępne formaty
        local formats = {
          { label = "ISO (R-M-D)", val = os.date("%Y-%m-%d", timestamp) },
          { label = "PL (D-M-R)",  val = os.date("%d-%m-%Y", timestamp) },
          { label = "Słowny",     val = os.date("%a %d %b %Y", timestamp) }, -- np. wto 17 lis 2026
        }

        -- Tworzymy listę etykiet do menu wybieraka (Snacks picker / vim.ui.select)
        local choices = {}
        for i, f in ipairs(formats) do
          table.insert(choices, string.format("%d. %s (%s)", i, f.label, f.val))
        end

        -- Wyświetlamy okno wyboru formatu
        vim.ui.select(choices, {
          prompt = string.format("Wybierz format dla %04d-%02d-%02d:", year, month, day),
        }, function(choice, idx)
          if not idx then return end
          local selected_val = formats[idx].val

          -- Zamykamy okno kalendarza i wracamy do poprzedniego bufora
          vim.cmd("q")

          -- Wstawiamy datę w miejscu kursora w buforze, z którego wywołano kalendarz
          vim.api.nvim_put({ selected_val }, "c", true, true)
        end)
      end

      -- Konfigurujemy zmienne globalne wymagane przez calendar.vim
      vim.g.calendar_task = 1
      -- Przypisujemy naszą funkcję jako akcję po naciśnięciu Enter
      vim.g.calendar_action = "call g:MyCalendarDatepicker"
    end,
  },
}
