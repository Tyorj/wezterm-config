local wezterm = require('wezterm')

---@class RightStatusOptions
---@field date_format string
---@field show_battery boolean

---@param opts? RightStatusOptions
local function normalize(opts)
   return {
      date_format = opts and opts.date_format or '%H:%M',
      show_battery = opts and opts.show_battery or false,
   }
end

local function battery_text()
   local info = wezterm.battery_info()
   if not info or #info == 0 then
      return nil
   end
   local b = info[1]
   return string.format('%.0f%%', b.state_of_charge * 100)
end

---@param opts? RightStatusOptions
local function setup(opts)
   local options = normalize(opts)

   wezterm.on('update-right-status', function(window, _pane)
      local pieces = { wezterm.strftime(options.date_format) }

      if options.show_battery then
         local bt = battery_text()
         if bt then
            table.insert(pieces, bt)
         end
      end

      window:set_right_status(wezterm.format({ { Text = table.concat(pieces, '  ') } }))
   end)
end

return { setup = setup }
