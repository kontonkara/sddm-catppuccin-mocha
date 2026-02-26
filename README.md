# SDDM Catppuccin Mocha Theme

A minimal and elegant SDDM login theme featuring the Catppuccin Mocha color palette with Lavender accent.

## Features

- **Catppuccin Mocha** color scheme with Lavender accent
- **Live clock** with seconds and date display
- **Configurable username field** (editable or locked mode)
- **Password visibility toggle** with eye icon
- **Session selector** with custom dropdown
- **Power controls** (reboot/shutdown)
- **Smooth animations** and hover effects
- **Background support** (solid color, images, GIF)
- **Multi-monitor support** with configurable primary display
- **Configurable icon colors** (white or black)
- **Component-based architecture** for easy customization

## Installation

1. Clone the repository:
```bash
git clone https://github.com/kontonkara/sddm-catppuccin-mocha.git
```

2. Copy the theme to SDDM themes directory:
```bash
sudo cp -r sddm-catppuccin-mocha /usr/share/sddm/themes/
```

3. Set the theme in SDDM configuration (`/etc/sddm.conf` or `/etc/sddm.conf.d/theme.conf`):
```ini
[Theme]
Current=sddm-catppuccin-mocha
```

## Configuration

Edit `theme.conf` to customize the theme:

```ini
[General]
# Username field: "editable" or "locked"
UsernameMode=locked

# Background type: "color" or "image"
BackgroundType=color

# For image backgrounds (optional)
# BackgroundPath=background.jpg
# BackgroundPath=background.gif

# Image blur intensity: 0-100
BackgroundBlur=0

# Background dimming: 0.0-1.0 (1.0 = no dim)
BackgroundDim=1.0

# Multi-monitor: specify monitor name for login form
# Examples: eDP-1, HDMI-1, DP-1, DP-2
# Leave empty for auto-detect (first screen)
PrimaryMonitor=

# Show background on secondary monitors
ShowBackgroundOnSecondary=true

# Icon color: "W" for white, "B" for black
IconColor=W
```

## Customization

### Colors

All colors follow the Catppuccin Mocha palette:
- **Base**: `#1e1e2e` - Background
- **Surface0**: `#313244` - Input fields
- **Lavender**: `#b4befe` - Accent color
- **Text**: `#cdd6f4` - Primary text
- **Subtext0**: `#a6adc8` - Labels

To change colors, edit the hex values in the QML components.

### Background

Place your background image in the theme directory and update `theme.conf`:
```ini
BackgroundType=image
BackgroundPath=background.jpg
BackgroundBlur=20
BackgroundDim=0.8
```

Supported formats: JPG, PNG, GIF

### Multi-monitor

To show the login form only on a specific monitor, set `PrimaryMonitor` in `theme.conf`:
```ini
# Show login form on laptop screen
PrimaryMonitor=eDP-1

# Show login form on external monitor
# PrimaryMonitor=HDMI-1
```

Leave `PrimaryMonitor` empty for auto-detection (uses the first screen).

## File Structure

```
sddm-catppuccin-mocha/
├── Main.qml              # Main theme entry
├── theme.conf            # Configuration file
├── metadata.desktop      # Theme metadata
├── Assets/               # Icons (SVG, W = white, B = black)
│   ├── UserW.svg / UserB.svg
│   ├── PasswordW.svg / PasswordB.svg
│   ├── PasswordShowW.svg / PasswordShowB.svg
│   ├── PasswordHideW.svg / PasswordHideB.svg
│   ├── RebootW.svg / RebootB.svg
│   └── ShutdownW.svg / ShutdownB.svg
└── Components/           # QML components
    ├── Background.qml
    ├── ClockComponent.qml
    ├── InputField.qml
    ├── PasswordField.qml
    ├── LoginButton.qml
    ├── SessionSelector.qml
    ├── PowerButtons.qml
    └── qmldir
```

## Requirements

- SDDM
- Qt 5.15+
- QtQuick 2.15
- QtQuick Controls 2.15

## Screenshots

*Coming soon*

## License

MIT License - see [LICENSE](LICENSE) file for details

## Credits

- Theme by [kontonkara](https://github.com/kontonkara)
- Color palette: [Catppuccin](https://github.com/catppuccin/catppuccin)

## Contributing

Issues and pull requests are welcome!
