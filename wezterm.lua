local Config = require('config')

-- Lightweight event wiring: simple tab titles and time-only status (battery optional)
require('events.tab-title').setup({ show_host = true })
require('events.right-status').setup({ date_format = '%H:%M', show_battery = false })
require('events.gui-startup').setup()

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options
