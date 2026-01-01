local wezterm = require('wezterm')
local platform = require('utils.platform')
local act = wezterm.action

local mod = {}

if platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
end

local leader = { key = 'CapsLock', mods = 'NONE', timeout_milliseconds = 1000 }

local function adjust_opacity_action(delta)
   return wezterm.action_callback(function(window, _pane)
      local overrides = window:get_config_overrides() or {}
      local current = overrides.window_background_opacity or 0.9
      local next_opacity = math.max(0.2, math.min(1.0, current + delta))

      overrides.window_background_opacity = next_opacity
      overrides.text_background_opacity = 1.0

      window:set_config_overrides(overrides)
   end)
end

local function reset_opacity_action()
   return wezterm.action_callback(function(window, _pane)
      local overrides = window:get_config_overrides() or {}
      overrides.window_background_opacity = nil
      overrides.text_background_opacity = nil
      window:set_config_overrides(overrides)
   end)
end

-- stylua: ignore
local keys = {
   -- copy/paste (keep the common shortcuts)
   { key = 'c',          mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
   { key = 'v',          mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },

   -- leader: tab management
   { key = 'c',          mods = 'LEADER',      action = act.SpawnTab('CurrentPaneDomain') },
   { key = 'x',          mods = 'LEADER',      action = act.CloseCurrentPane({ confirm = true }) },
   { key = 'b',          mods = 'LEADER',      action = act.ActivateTabRelative(-1) },
   { key = 'n',          mods = 'LEADER',      action = act.ActivateTabRelative(1) },
   { key = '0',          mods = 'LEADER',      action = act.ActivateTab(0) },
   { key = '1',          mods = 'LEADER',      action = act.ActivateTab(1) },
   { key = '2',          mods = 'LEADER',      action = act.ActivateTab(2) },
   { key = '3',          mods = 'LEADER',      action = act.ActivateTab(3) },
   { key = '4',          mods = 'LEADER',      action = act.ActivateTab(4) },
   { key = '5',          mods = 'LEADER',      action = act.ActivateTab(5) },
   { key = '6',          mods = 'LEADER',      action = act.ActivateTab(6) },
   { key = '7',          mods = 'LEADER',      action = act.ActivateTab(7) },
   { key = '8',          mods = 'LEADER',      action = act.ActivateTab(8) },
   { key = '9',          mods = 'LEADER',      action = act.ActivateTab(9) },

   -- leader: pane splitting
   { key = '|',          mods = 'LEADER',      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
   { key = '-',          mods = 'LEADER',      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },

   -- leader: pane navigation
   { key = 'h',          mods = 'LEADER',      action = act.ActivatePaneDirection('Left') },
   { key = 'j',          mods = 'LEADER',      action = act.ActivatePaneDirection('Down') },
   { key = 'k',          mods = 'LEADER',      action = act.ActivatePaneDirection('Up') },
   { key = 'l',          mods = 'LEADER',      action = act.ActivatePaneDirection('Right') },

   -- leader: pane resizing
   { key = 'LeftArrow',  mods = 'LEADER',      action = act.AdjustPaneSize({ 'Left', 5 }) },
   { key = 'RightArrow', mods = 'LEADER',      action = act.AdjustPaneSize({ 'Right', 5 }) },
   { key = 'DownArrow',  mods = 'LEADER',      action = act.AdjustPaneSize({ 'Down', 5 }) },
   { key = 'UpArrow',    mods = 'LEADER',      action = act.AdjustPaneSize({ 'Up', 5 }) },

   -- font size controls (ALT on Win/Linux, SUPER on mac)
   { key = '=',          mods = mod.SUPER,     action = act.IncreaseFontSize },
   { key = '-',          mods = mod.SUPER,     action = act.DecreaseFontSize },
   { key = '0',          mods = mod.SUPER,     action = act.ResetFontSize },

   -- opacity controls (stronger modifier to avoid conflicts)
   { key = '[',          mods = mod.SUPER_REV, action = adjust_opacity_action(-0.05) },
   { key = ']',          mods = mod.SUPER_REV, action = adjust_opacity_action(0.05) },
   { key = [[\]],       mods = mod.SUPER_REV, action = reset_opacity_action() },

   -- misc/useful
   { key = 'F2',         mods = 'NONE',        action = act.ActivateCommandPalette },
   { key = 'F3',         mods = 'NONE',        action = act.ShowLauncher },
   { key = 'F4',         mods = 'NONE',        action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
   { key = 'F11',        mods = 'NONE',        action = act.ToggleFullScreen },
}

local mouse_bindings = {
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}

return {
   disable_default_key_bindings = true,
   leader = leader,
   keys = keys,
   key_tables = {},
   mouse_bindings = mouse_bindings,
}
