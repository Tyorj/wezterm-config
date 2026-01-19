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

local function user_host(pane)
   if not pane then
      return nil
   end

   -- Try to get user@host from shell integration user vars
   local user_vars = pane:get_user_vars()
   -- Check both Unix (USER) and Windows (USERNAME) environment variables
   local user = user_vars.WEZTERM_USER or user_vars.USER or user_vars.USERNAME
   local host = user_vars.WEZTERM_HOST or user_vars.HOSTNAME or user_vars.COMPUTERNAME
   
   -- Fallback to wezterm.hostname() if not available
   if not host or #host == 0 then
      host = wezterm.hostname()
   end

   if not user then
      user = os.getenv("USERNAME") or os.getenv("USER")
   end
   
   -- If we have user info, return user@host, otherwise just host
   if user and #user > 0 then
      return user .. '@' .. host
   elseif host and #host > 0 then
      return host
   end
   
   return nil
end

---@param opts? RightStatusOptions
local function setup(opts)
   local options = normalize(opts)

   wezterm.on('update-right-status', function(window, pane)
      local pieces = {}

      local leader_active = window:leader_is_active()
      local key_table = window:active_key_table()
      local workspace = window:active_workspace()
      local user_host_info = user_host(pane)
      local domain = pane:get_domain_name()

      if leader_active then
         table.insert(pieces, '[LDR]')
      end

      if key_table then
         table.insert(pieces, '[KT:' .. key_table .. ']')
      end

      if domain then
         table.insert(pieces, '[' .. domain .. ']')
      end

      if user_host_info and #user_host_info > 0 then
         table.insert(pieces, user_host_info)
      end

      if workspace and #workspace > 0 then
         table.insert(pieces, 'ws:' .. workspace)
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
