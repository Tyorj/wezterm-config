## Lean WezTerm (Gruvbox)

Lightweight, cross-platform WezTerm setup for Arch (zsh) and Windows (PowerShell/WSL) with Gruvbox Dark, minimal keymaps, simple tab/status text, and per-OS font sizes. Defaults to WebGPU fallback and maximizes on launch.

### What’s inside
- Gruvbox Dark palette and trimmed UI in [config/appearance.lua](config/appearance.lua)
- JetBrainsMono Nerd Font sizing: mac 12, win/linux 10 in [config/fonts.lua](config/fonts.lua)
- Essential keymaps (palette, fuzzy tab switcher, search, tabs, panes, copy/paste) in [config/bindings.lua](config/bindings.lua)
- Time-only status (battery optional) and tab titles as `index: title @ host` in [events/right-status.lua](events/right-status.lua) and [events/tab-title.lua](events/tab-title.lua)
- Minimal launch menus for Arch zsh/fish/bash and Windows pwsh/cmd/WSL in [config/launch.lua](config/launch.lua); simple WSL stub in [config/domains.lua](config/domains.lua)
- Entry wiring in [wezterm.lua](wezterm.lua); GUI maximizes on startup
- Optional GPU adapter helper kept for troubleshooting in [utils/gpu-adapter.lua](utils/gpu-adapter.lua)

### Install
1) Install WezTerm (stable or nightly) and JetBrainsMono Nerd Font.  
2) Clone into your WezTerm config dir (e.g., `~/.config/wezterm` or `%USERPROFILE%\.wezterm` on Windows).
3) Start WezTerm; it will auto-maximize.

### Key bindings (core)
- F1 copy mode, F2 palette, F3 launcher, F4 fuzzy tabs, F11 fullscreen
- SUPER+f search; SUPER+t new tab; SUPER_REV+w close tab; SUPER+[ / ] cycle tabs
- SUPER+\ split vertical; SUPER_REV+\ split horizontal; SUPER+Enter pane zoom; SUPER_REV+Enter maximize window
- SUPER_REV+h/j/k/l move panes; SUPER_REV+p swap panes; SUPER+u/d scroll; PageUp/PageDown page scroll
- Ctrl+Shift+c/v copy/paste

**Mod keys:** mac → SUPER=Cmd, SUPER_REV=Cmd+Ctrl. Windows/Linux → SUPER=Alt, SUPER_REV=Alt+Ctrl. Leader = SUPER_REV+Space.

### Customization quick hits
- Toggle battery text: set `show_battery = true` in [events/right-status.lua](events/right-status.lua)
- Change default shells/WSL distro: [config/launch.lua](config/launch.lua) and [config/domains.lua](config/domains.lua)
- Adjust fonts or Gruvbox shades: [config/fonts.lua](config/fonts.lua) and [colors/custom.lua](colors/custom.lua)

### Notes
- Background images and complex tab/status UI were removed for speed and clarity.
- GPU adapter picker is kept but unused by default; wire it back in [config/appearance.lua](config/appearance.lua) if you need to pin a backend/adapter.
