local wezterm = require('wezterm')

---@class TabTitleOptions
---@field show_host boolean

---@param title string
---@param max_width integer
local function truncate(title, max_width)
   if title:len() <= max_width then
      return title
   end
   if max_width <= 3 then
      return title:sub(1, max_width)
   end
   return title:sub(1, max_width - 3) .. '...'
end

---@param opts? TabTitleOptions
local function setup(opts)
   local show_host = opts and opts.show_host or false
   local host = show_host and wezterm.hostname() or ''

   wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, _hover, max_width)
      local idx = tab.tab_index + 1
      local base_title = tab.active_pane.title or ''
      local pieces = { tostring(idx) .. ':', base_title }

      if show_host and host and #host > 0 then
         table.insert(pieces, '@')
         table.insert(pieces, host)
      end

      local text = table.concat(pieces, ' ')
      text = truncate(text, max_width)

      return {
         { Text = ' ' .. text .. ' ' },
      }
   end)
end

return { setup = setup }
