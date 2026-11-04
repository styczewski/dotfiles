return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { 
    "nvim-treesitter/nvim-treesitter", 
    "nvim-tree/nvim-web-devicons" 
  },
  ft = { "markdown" },
  opts = {
    -- Domyślna konfiguracja działa świetnie wyjęta z pudełka,
    -- ale możesz dostosować np. znaki nagłówków lub zachowanie przy conceal:
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰄵 " },
    },
  },
}
