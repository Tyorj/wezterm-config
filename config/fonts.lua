local wezterm = require('wezterm')
local platform = require('utils.platform')

-- local font_family = 'Maple Mono NF'
local font_family = 'JetBrainsMono Nerd Font'
-- local font_family = 'CartographCF Nerd Font'

local font_size
if platform.is_mac then
   font_size = 12
elseif platform.is_win then
   font_size = 10
else
   font_size = 10
end

return {
   font = wezterm.font_with_fallback({
      {
         family = font_family,
         weight = 'Medium',
      },
      'Noto Color Emoji',
      'Noto Sans CJK SC',
   }),
   font_size = font_size,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
