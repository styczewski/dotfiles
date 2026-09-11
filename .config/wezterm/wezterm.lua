local wezterm = require 'wezterm'
local config = wezterm.config_builder()

--------------------------------------------------------------------------------
-- 1. WYGLĄD I MOTYW (LOOK & FEEL)
--------------------------------------------------------------------------------
-- Wybierz schemat kolorów (np. Catppuccin Mocha, Tokyo Night, Gruvbox Dark)
config.color_scheme = 'Catppuccin Mocha'

-- Czcionka (z automatycznym wsparciem dla ikon Nerdfonts)
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'Fira Code',
  'Noto Color Emoji',
})
config.font_size = 10.5

-- Okno i ramki
config.window_background_opacity = 0.95
config.enable_scroll_bar = false
config.window_decorations = "RESIZE" -- Brak zbędnych belkowych nagłówków systemowych
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

--------------------------------------------------------------------------------
-- 2. PASEK KART I STATUSU (TAB BAR & STATUS - STYL TMUX)
--------------------------------------------------------------------------------
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true -- Pasek kart na dole, tak jak domyślnie w tmux
config.hide_tab_bar_if_only_one_tab = false

-- Formatowanie etykiety karty (np. "1: bash")
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local index = tab.tab_index + 1
  if tab.is_active then
    return {
      { Background = { Color = '#89b4fa' } },
      { Foreground = { Color = '#1e1e2e' } },
      { Text = string.format(' %d: %s ', index, title) },
    }
  end
  return {
    { Background = { Color = '#313244' } },
    { Foreground = { Color = '#cdd6f4' } },
    { Text = string.format(' %d: %s ', index, title) },
  }
end)

-- Prawy pasek statusu (Data, czas, nazwa hosta/sesji)
wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime('%Y-%m-%d %H:%M')
  local hostname = wezterm.hostname()
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#89b4fa' } },
    { Text = ' ' .. hostname .. ' ' },
    { Foreground = { Color = '#6c7086' } },
    { Text = '|' },
    { Foreground = { Color = '#a6e3a1' } },
    { Text = ' ' .. date .. ' ' },
  }))
end)

--------------------------------------------------------------------------------
-- 3. SKRÓTY KLAWISZOWE (PREFIX: `)
--------------------------------------------------------------------------------
-- Główny klawisz prefiksu: ` (backtick / grawis)
config.leader = { key = '`', mods = 'NONE', timeout_milliseconds = 1000 }

config.keys = {
  -- Wpisanie fizycznego znaku ` po dwukrotnym szybkimi naciśnięciu (``)
  { key = '`', mods = 'LEADER', action = wezterm.action.SendKey { key = '`' } },

  -- Podział okna (Splits)
  { key = '|', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER',       action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Nawigacja między panelami w stylu Vima (` + h/j/k/l)
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- Zmiana rozmiaru paneli (` + Strzałki)
  { key = 'LeftArrow',  mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow',  mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },

  -- Powiększenie aktywnego panelu (` + z)
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },

  -- Zarządzanie kartami (` + c, n, p, x, &)
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = '&', mods = 'LEADER|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },

  -- Szybkie przełączanie kart po numerze (` + 1..9)
  { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = wezterm.action.ActivateTab(8) },

  -- Tryb kopiowania / przewijania (` + [)
  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
}

--------------------------------------------------------------------------------
-- 4. OCHRONA PRZED PRZYPADKOWYM ZAMKNIĘCIEM I INNE
--------------------------------------------------------------------------------
config.scrollback_lines = 10000
config.check_for_updates = false

return config
