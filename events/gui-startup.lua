local wezterm = require('wezterm')
local mux = wezterm.mux
local platform = require('utils.platform')

local M = {}

M.setup = function()
   wezterm.on('gui-startup', function(cmd)
      if platform.is_win then
         -- Windows: fixed size window positioned on right-middle of screen
         local screen = wezterm.gui.screens().active
         local screen_width = screen.width
         local screen_height = screen.height
         
         -- Position on right-middle with reasonable margin
         local x = math.floor(screen_width * 0.6)  -- right-center area
         local y = math.floor((screen_height - 800) / 2)  -- vertically centered with estimated height
         
         local _, _, window = mux.spawn_window(cmd or {})
         local gui_window = window:gui_window()
         if gui_window then
            gui_window:set_position(x, y)
            -- Slightly larger: 270 cols * 8px, 190 rows * 17px
            gui_window:set_inner_size(1280, 970)
         end
      else
         -- Linux and other platforms: maximize window
         local _, _, window = mux.spawn_window(cmd or {})
         local gui_window = window:gui_window()
         if gui_window then
            gui_window:maximize()
         end
      end
   end)
end

return M
