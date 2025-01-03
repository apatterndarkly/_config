local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.scrollback_lines = 10000
config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'Sweet Love (terminal.sexy)'
config.window_background_opacity = 0.80
config.font_size = 16.0
config.line_height = 1.4

config.font = wezterm.font_with_fallback {
  'D2CodingLigature Nerd Font',
  'ZedMono Nerd Font',
}

config.default_prog = { '/home/apd/.cargo/bin/nu' }

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config


-- config.color_scheme = 'Trim Yer Beard (terminal.sexy)'
-- config.color_scheme = 'Twilight (dark) (terminal.sexy)'
-- config.color_scheme = 'Jellybeans (Gogh)'
-- config.color_scheme = 'Twilight (Gogh)'
-- config.color_scheme = 'Dawn (terminal.sexy)'

-- config.color_scheme = 'Sundried'
-- config.color_scheme = 'Treehouse'
-- config.color_scheme = 'Tomorrow Night Burns'
-- config.color_scheme = 'Tomorrow Night Bright (Gogh)'
-- config.color_scheme = 'Tomorrow Night (Gogh)'
-- config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'
-- config.color_scheme = 'Thayer Bright'
-- config.color_scheme = 'Teva (terminal.sexy)'
-- config.color_scheme = 'Terminix Dark (Gogh)'
-- config.color_scheme = 'Tangoesque (terminal.sexy)'
-- config.color_scheme = 'synthwave'
-- config.color_scheme = 'Synth Midnight Terminal Dark (base16)'
-- config.color_scheme = 'Symfonic'
-- config.color_scheme = 'Symphonic (Gogh)'
-- config.color_scheme = 'Sweet Love (terminal.sexy)'
-- config.color_scheme = 'Srcery (Gogh)'
-- config.color_scheme = 'Square'
-- config.color_scheme = 'Spacemacs (base16)'
-- config.color_scheme = 'Spacegray Eighties Dull (Gogh)'
-- config.color_scheme = 'SpaceGray Eighties'
-- config.color_scheme = 'Spacegray (Gogh)'
-- config.color_scheme = 'Spacedust (Gogh)'
-- config.color_scheme = 'Sonokai (Gogh)'
-- config.color_scheme = 'Solarized Dark Higher Contrast (Gogh)'
-- config.color_scheme = 'Solarized Dark - Patched'
-- config.color_scheme = 'Smyck'
-- config.color_scheme = 'Sequoia Moonlight'
-- config.color_scheme = 'Seti (Gogh)'
-- config.color_scheme = 'Sagelight (base16)'
-- config.color_scheme = 'Royal (Gogh)'
-- config.color_scheme = 'Rosé Pine (Gogh)'
-- config.color_scheme = 'Railscasts (dark) (terminal.sexy)'
-- config.color_scheme = 'Qualia (base16)'
-- config.color_scheme = 'Pulp (terminal.sexy)'
-- config.color_scheme = 'Popping and Locking'
-- config.color_scheme = 'Pnevma'
-- config.color_scheme = 'Papercolor Dark (Gogh)'
-- config.color_scheme = 'Panels (terminal.sexy)'
-- config.color_scheme = 'Oxocarbon Dark (Gogh)'
-- config.color_scheme = 'Operator Mono Dark'
-- config.color_scheme = 'Oceanic-Next'
-- config.color_scheme = 'NvimDark'
-- config.color_scheme = 'Neutron'
-- This is where you actually apply your config choices
-- config.color_scheme = 'Hybrid'
-- config.color_scheme = 'Framer'
-- config.color_scheme = 'Afterglow (Gogh)'
-- config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Hardcore (Gogh)'
-- config.color_scheme = '3024 Night (Gogh)'
-- config.color_scheme = 'zenwritten_dark'
-- config.color_scheme = 'zenbones_dark'
-- config.color_scheme = 'X::DotShare (terminal.sexy)'
-- config.color_scheme = 'Wryan (Gogh)'
-- config.color_scheme = 'Woodland (base16)'
-- config.color_scheme = 'Wild Cherry (Gogh)'
-- config.color_scheme = 'VWbug (terminal.sexy)'
-- config.color_scheme = 'Vag (Gogh)'
-- config.color_scheme = 'Vacuous 2 (terminal.sexy)'
-- config.color_scheme = 'Unsifted Wheat (terminal.sexy)'
-- config.color_scheme = 'Unikitty Dark (base16)'
-- config.color_scheme = 'UltraDark'
-- config.color_scheme = 'Twilight (Gogh)'
-- config.color_scheme = 'Twilight (dark) (terminal.sexy)'
-- config.color_scheme = 'Hopscotch'
-- config.color_scheme = 'Humanoid dark (base16)'
-- config.color_scheme = 'hund (terminal.sexy)'
-- config.color_scheme = 'Hybrid (Gogh)'
-- config.color_scheme = 'Jellybeans (Gogh)'
-- config.color_scheme = 'Kimber (base16)'
-- config.color_scheme = 'LiquidCarbonTransparent'
-- config.color_scheme = 'Liquid Carbon Transparent (Gogh)'
-- config.color_scheme = 'MaterialDarker'
-- config.color_scheme = 'Mellifluous'
-- config.color_scheme = 'Monokai Soda (Gogh)'
-- config.color_scheme = 'Modus-Vivendi'
-- config.color_scheme = 'Muse (terminal.sexy)'
