## WezTerm Configuration

This is a WezTerm setup for Arch (zsh) and Windows (PowerShell/WSL) with Gruvbox Dark theme.

### Files and what they do

- **config/appearance.lua** - Sets Gruvbox Dark colors and UI trimming
- **config/fonts.lua** - Configures JetBrainsMono Nerd Font sizes (mac 12, win/linux 10)
- **config/bindings.lua** - Defines keybindings for navigation, tabs, and panes
- **events/right-status.lua** - Shows leader/key table status, workspace, current working directory, time, and optional battery status
- **events/tab-title.lua** - Formats tab titles as `index: title @ host`
- **config/launch.lua** - Sets available shells (zsh/fish/bash on Arch, pwsh/cmd/WSL on Windows)
- **config/domains.lua** - WSL domain configuration
- **wezterm.lua** - Main entry point that loads all configs
- **utils/gpu-adapter.lua** - GPU adapter selection helper (optional)

### Installation

1. Install WezTerm and JetBrainsMono Nerd Font
2. Clone this repo into your WezTerm config directory:
   - Linux/Mac: `~/.config/wezterm`
   - Windows: `%USERPROFILE%\.wezterm`
3. Launch WezTerm (will maximize automatically)

### Key bindings

All bindings use **Leader** mode (CapsLock by default, 2 second timeout).

#### Copy/Paste
- **Ctrl+Shift+c** - Copy to clipboard
- **Ctrl+Shift+v** - Paste from clipboard

#### Tab Management (Leader prefix)
- **Leader+c** - Create new tab
- **Leader+x** - Close current pane (with confirmation)
- **Leader+b** - Previous tab
- **Leader+n** - Next tab
- **Leader+0-9** - Switch to tab 0-9

#### Pane Splitting (Leader prefix)
- **Leader+|** - Split horizontal
- **Leader+-** - Split vertical

#### Pane Navigation (Leader prefix)
- **Leader+h/j/k/l** - Move left/down/up/right

#### Pane Resizing (Leader prefix)
- **Leader+Arrow Keys** - Resize pane by 5 pixels

#### Font Controls
- **Alt+=** (Windows/Linux) or **Cmd+=** (Mac) - Increase font size
- **Alt+-** (Windows/Linux) or **Cmd+-** (Mac) - Decrease font size
- **Alt+0** (Windows/Linux) or **Cmd+0** (Mac) - Reset font size

#### Opacity Controls
- **Alt+Ctrl+[** - Decrease opacity
- **Alt+Ctrl+]** - Increase opacity
- **Alt+Ctrl+\** - Reset opacity

#### Miscellaneous
- **F2** - Command palette
- **F3** - Launcher
- **F4** - Fuzzy tab switcher
- **F11** - Fullscreen
- **Ctrl+Click** - Open link at cursor

**Mod keys:**
- Mac: SUPER = Cmd, SUPER_REV = Cmd+Ctrl
- Windows/Linux: SUPER = Alt, SUPER_REV = Alt+Ctrl

### Configuration options

- **Battery display** - Set `show_battery = true` in `events/right-status.lua`
- **Default shells** - Edit `config/launch.lua` and `config/domains.lua`
- **Fonts** - Adjust in `config/fonts.lua`
- **Colors** - Modify Gruvbox values in `colors/custom.lua`
- **GPU adapter** - Wire in `config/appearance.lua` if needed
