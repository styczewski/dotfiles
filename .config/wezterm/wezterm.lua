local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Włączenie pełnego przetwarzania grafik oraz analizy protokołów
config.enable_kitty_graphics = true

-- -----------------------------------------------------------------------------
-- 2. Wymiary okna i pasek kart na dole (jak w Tmuxie)
-- -----------------------------------------------------------------------------
config.initial_cols = 110
config.initial_rows = 35
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

-- Indeksowanie kart od 1 zamiast od 0
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tab.tab_index + 1
  local title = tab.active_pane.title
  if tab.tab_title and #tab.tab_title > 0 then
    title = tab.tab_title
  end
  return {
    { Text = ' ' .. index .. ': ' .. title .. ' ' },
  }
end)

-- -----------------------------------------------------------------------------
-- 3. Wygląd okna, marginesy i przezroczystość
-- -----------------------------------------------------------------------------
config.window_decorations = "RESIZE"
config.window_padding = {
  left = '0pt',
  right = '0pt',
  top = '0pt',
  bottom = '0pt',
}
config.window_background_opacity = 0.9

-- -----------------------------------------------------------------------------
-- 4. Paleta kolorów (Coolnight + Własny kolor aktywnej karty)
-- -----------------------------------------------------------------------------
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },

  -- Konfiguracja kolorów paska kart:
  tab_bar = {
    -- Tło całego paska (tam gdzie nie ma kart)
    background = '#010f1a',

    -- Aktywna karta
    active_tab = {
      bg_color = '#1e2030', -- Twój wybrany kolor
      fg_color = '#47FF9C', -- Kolor tekstu (seledynowy pasujący do kursora)
      intensity = 'Bold',
    },

    -- Nieaktywne karty
    inactive_tab = {
      bg_color = '#011423',
      fg_color = '#6272a4',
    },

    -- Nieaktywne karty po najechaniu myszką
    inactive_tab_hover = {
      bg_color = '#033259',
      fg_color = '#CBE0F0',
    },

    -- Przycisk nowej karty (+)
    new_tab = {
      bg_color = '#011423',
      fg_color = '#6272a4',
    },
    new_tab_hover = {
      bg_color = '#033259',
      fg_color = '#47FF9C',
    },
  },
}

-- -----------------------------------------------------------------------------
-- 5. Typografia domyślna
-- -----------------------------------------------------------------------------
config.font = wezterm.font_with_fallback({
  'Ubuntu Mono',
  'Liberation Mono',
  'Consolas',
})
config.font_size = 10.0
config.line_height = 1.2

-- -----------------------------------------------------------------------------
-- 6. Kursor i zachowanie
-- -----------------------------------------------------------------------------
config.default_cursor_style = 'SteadyBlock'
config.animation_fps = 1
config.cursor_blink_rate = 0

-- -----------------------------------------------------------------------------
-- 7. KLAWISZ LEADER (Backtick / Tylda `)
-- -----------------------------------------------------------------------------
config.leader = { key = '`', timeout_milliseconds = 1000 }

config.keys = {
  -- Dwukrotne naciśnięcie ` wysyła fizyczny znak `
  {
    key = '`',
    mods = 'LEADER',
    action = wezterm.action.SendKey { key = '`' },
  },

  -- --- ZMIANA NAZWY KARTY ( Leader + , ) ---
  {
    key = ',',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Podaj nowa nazwe karty:',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  -- --- PRZESUWANIE KART / STRON ( Leader + [ oraz Leader + ] ) ---
  { key = '[', mods = 'LEADER', action = wezterm.action.MoveTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = wezterm.action.MoveTabRelative(1) },
  -- Działające również bezpośrednio z Alt (gdybyś wolał bez Leadera)
  { key = '[', mods = 'ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = ']', mods = 'ALT', action = wezterm.action.MoveTabRelative(1) },

  -- --- PODZIAŁ PANELI ( Leader + i / o ) ---
  { key = 'i', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = 'o', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },

  -- --- NAWIGACJA PO PANELACH ( Leader + h / j / k / l ) ---
  { key = 'h', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- --- ZAMYKANIE PANELU ( Leader + x ) ---
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },

  -- --- ZMIANA ROZMIARU PANELI ( Leader + Shift + H / J / K / L ) ---
  { key = 'H', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 2 } },
  { key = 'J', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 2 } },
  { key = 'K', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 2 } },
  { key = 'L', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 2 } },

  -- --- ZARZĄDZANIE KARTAMI (TABS) ---
  -- Leader + c -> Nowa karta
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnCommandInNewTab { cwd = wezterm.home_dir },
  },
  -- Leader + n / Leader + p -> Następna / Poprzednia karta
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },

  -- Leader + 1..9 -> Skok do karty 1..9
  { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = wezterm.action.ActivateTab(8) },

  -- --- TRYB CZYTANIA (Alt + R) I PEŁNY EKRAN (Alt + Enter) ---
  {
    key = 'r',
    mods = 'ALT',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if not overrides.font then
        overrides.font = wezterm.font_with_fallback({
          'JetBrains Mono',
		  'Courier Prime',
          'Courier New',
        })
        overrides.font_size = 13.5
        overrides.line_height = 1.1
        overrides.cell_width = 0.8
      else
        overrides.font = nil
        overrides.font_size = nil
        overrides.line_height = nil
        overrides.cell_width = nil
      end
      window:set_config_overrides(overrides)
    end),
  },
  { key = 'Enter', mods = 'ALT', action = wezterm.action.ToggleFullScreen },

  -- --j ZOOM TERMINALA (CTRL + / - / 0) ---
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
}

config.audible_bell = "Disabled"

return config
