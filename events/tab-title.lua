local wezterm = require('wezterm')

---@class TabTitleOptions
---@field show_host boolean

---@param title string
---@param max_width integer
local function truncate(title, max_width)
   if title:len() <= max_width then
      return title
   end
   if max_width <= 10 then
      return title:sub(1, max_width)
   end
   return title:sub(1, max_width - 10) .. '...'
end

---@param opts? TabTitleOptions
local function setup(opts)
   local show_host = opts and opts.show_host or false

   wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, _hover, max_width)
      local idx = tab.tab_index + 1 -- Display 1-based index (matches keyboard shortcuts)
      local pane = tab.active_pane
      local user_vars = pane.user_vars or {}

      -- Priority A: The manual variable we pushed from the shell hook (Perfect accuracy)
      local process_name = user_vars.WEZTERM_PROG

      -- Priority B: The system process name (Good for local Windows, bad for WSL via wsl.exe)
      if not process_name then
         local name = pane.foreground_process_name or ''
         process_name = name:match('([^/\\]+)$') or name
      end

      -- Priority C: The tab title (Last resort if process is just the wrapper)
      if process_name == '' or process_name == 'wslhost.exe' or process_name == 'wsl.exe' then
          local title_guess = (pane.title or ''):match('([^/\\]+)$') or pane.title or ''
          if title_guess ~= '' then
              process_name = title_guess
          end
      end

      -- 3. Build the String
      local pieces = { tostring(idx) .. ':' }

      table.insert(pieces, process_name)
      table.insert(pieces, '|') -- Visual separator

      local text = table.concat(pieces, ' ')
      text = truncate(text, max_width)

      return {
         { Text = ' ' .. text .. ' ' },
      }
   end)
end

return { setup = setup }