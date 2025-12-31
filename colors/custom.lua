-- Gruvbox Dark palette tuned for WezTerm
-- stylua: ignore
local gruvbox = {
   bg0        = '#282828',
   bg1        = '#3c3836',
   bg2        = '#504945',
   fg         = '#ebdbb2',
   fg_dim     = '#d5c4a1',
   red        = '#fb4934',
   green      = '#b8bb26',
   yellow     = '#fabd2f',
   blue       = '#83a598',
   purple     = '#d3869b',
   aqua       = '#8ec07c',
   orange     = '#fe8019',
   gray       = '#928374',
}

local colorscheme = {
   foreground = gruvbox.fg,
   background = gruvbox.bg0,
   cursor_bg = gruvbox.yellow,
   cursor_border = gruvbox.yellow,
   cursor_fg = gruvbox.bg0,
   selection_bg = gruvbox.bg2,
   selection_fg = gruvbox.fg,
   ansi = {
      gruvbox.bg1,     -- black
      gruvbox.red,     -- red
      gruvbox.green,   -- green
      gruvbox.yellow,  -- yellow
      gruvbox.blue,    -- blue
      gruvbox.purple,  -- magenta
      gruvbox.aqua,    -- cyan
      gruvbox.fg_dim,  -- white
   },
   brights = {
      gruvbox.gray,    -- black
      gruvbox.red,     -- red
      gruvbox.green,   -- green
      gruvbox.yellow,  -- yellow
      gruvbox.blue,    -- blue
      gruvbox.purple,  -- magenta
      gruvbox.aqua,    -- cyan
      gruvbox.fg,      -- white
   },
   tab_bar = {
      background = gruvbox.bg0,
      active_tab = {
         bg_color = gruvbox.bg2,
         fg_color = gruvbox.fg,
      },
      inactive_tab = {
         bg_color = gruvbox.bg1,
         fg_color = gruvbox.fg_dim,
      },
      inactive_tab_hover = {
         bg_color = gruvbox.bg2,
         fg_color = gruvbox.fg,
      },
      new_tab = {
         bg_color = gruvbox.bg1,
         fg_color = gruvbox.fg_dim,
      },
      new_tab_hover = {
         bg_color = gruvbox.bg2,
         fg_color = gruvbox.fg,
      },
   },
   visual_bell = gruvbox.orange,
   scrollbar_thumb = gruvbox.bg2,
   split = gruvbox.bg2,
   compose_cursor = gruvbox.purple,
}

return colorscheme
