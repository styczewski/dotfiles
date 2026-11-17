return {
  {
    "Dzejkop/datepicker.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      { "<leader>oc", "<cmd>DatePickerOpen<cr>", desc = "Otwórz datepicker" }, -- lub podpięte pod funkcję niżej
    },
    config = function()
      vim.keymap.set("n", "<leader>oc", function()
        require("datepicker").open({
          week_start = "monday",
          on_select = function(d)
            -- d zwraca obiekt z datą (zazwyczaj rok, miesiąc, dzień)
            if not d or not d.year or not d.month or not d.day then
              return
            end

            local date_table = { year = d.year, month = d.month, day = d.day }
            local timestamp = os.time(date_table)

            local formats = {
              { label = "ISO (R-M-D)", val = os.date("%Y-%m-%d", timestamp) },
              { label = "PL (D-M-R)",  val = os.date("%d-%m-%Y", timestamp) },
              { label = "Słowny",     val = os.date("%a %d %b %Y", timestamp) },
            }

            local choices = {}
            for i, f in ipairs(formats) do
              table.insert(choices, string.format("%d. %s (%s)", i, f.label, f.val))
            end

            vim.ui.select(choices, {
              prompt = string.format("Wybierz format dla %04d-%02d-%02d:", d.year, d.month, d.day),
            }, function(choice, idx)
              if not idx then return end
              local selected_val = formats[idx].val
              vim.api.nvim_put({ selected_val }, "c", true, true)
            end)
          end,
        })
      end, { desc = "Wybierz datę z kalendarza" })
    end,
  },
}
