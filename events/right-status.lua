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

local function cwd_snippet(pane)
   if not pane then
      return nil
   end

   local cwd_uri = pane:get_current_working_dir()
   if not cwd_uri then
      return nil
   end

   local path = cwd_uri.file_path or tostring(cwd_uri)
   if not path or #path == 0 then
      return nil
   end

   path = path:gsub('^file://', '')
   path = path:gsub('^/([A-Za-z]:)', '%1')
   path = path:gsub('\\', '/')

   local parts = {}
   for part in path:gmatch('[^/]+') do
      table.insert(parts, part)
   end

   local count = #parts
   if count == 0 then
      return nil
   elseif count == 1 then
      return parts[1]
   else
      return table.concat({ parts[count - 1], parts[count] }, '/')
   end
end

---@param opts? RightStatusOptions
local function setup(opts)
   local options = normalize(opts)

   wezterm.on('update-right-status', function(window, pane)
      local pieces = {}

      local leader_active = window:leader_is_active()
      local key_table = window:active_key_table()
      local workspace = window:active_workspace()
      local cwd = cwd_snippet(pane)

      if leader_active then
         table.insert(pieces, '[LDR]')
      end

      if key_table then
         table.insert(pieces, '[KT:' .. key_table .. ']')
      end

      if workspace and #workspace > 0 then
         table.insert(pieces, 'ws:' .. workspace)
      end

      if cwd and #cwd > 0 then
         table.insert(pieces, cwd)
      end

      table.insert(pieces, wezterm.strftime(options.date_format))

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
