local wezterm = require('wezterm')
local platform = require('utils.platform')

local options = {
   ssh_domains = {},
   unix_domains = {},
   wsl_domains = {},
}

if platform.is_win then
   local wsl_domains = wezterm.default_wsl_domains()

   for _, dom in ipairs(wsl_domains) do
      
      if dom.name == 'WSL:archlinux' then
         dom.default_prog = { 'zsh', '-l' }
      end

      if dom.name == 'WSL:Ubuntu' then
          -- dom.default_prog = ...
      end
   end
   
   options.wsl_domains = wsl_domains
end

return options