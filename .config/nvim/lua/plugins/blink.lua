return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      -- Wyłącza automatyczne zaznaczanie pierwszej podpowiedzi na liście
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
  },
}
