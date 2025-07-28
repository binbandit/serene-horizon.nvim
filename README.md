# 🌊 Serene Horizon

A soothing, eye-friendly Neovim theme inspired by a serene ocean horizon. Featuring original cool-toned colors for calm focus: deep blues, soft aquas, lavenders, and sages. Designed to be visually stunning like minimalist artwork, with balanced contrasts for readability.

## Features

- 🎨 Three beautiful variants:
  - **Dark Original**: Deep oceanic blue background
  - **Dark Black**: Pure black background for OLED displays
  - **Light**: Pale sky blue background
- 🌲 Comprehensive Treesitter support
- 🔍 LSP diagnostics styling
- 🔭 Telescope integration
- 📁 NvimTree support
- 🔀 GitSigns colors
- ✨ Support for popular plugins (cmp, notify, indent-blankline, noice, diffview, lazy)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "binbandit/serene-horizon.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Load the default dark variant
    vim.cmd([[colorscheme serene_horizon]])
    
    -- Or configure specific variant
    require('serene_horizon').setup({
      mode = 'dark',     -- 'dark' or 'light'
      variant = 'original' -- 'original' or 'black' (dark mode only)
    })
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'binbandit/serene-horizon.nvim',
  config = function()
    vim.cmd([[colorscheme serene_horizon]])
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'binbandit/serene-horizon.nvim'

" In your init.vim
colorscheme serene_horizon
```

## Usage

### Basic usage

```vim
" Load default dark variant
colorscheme serene_horizon

" Load dark black variant
colorscheme serene_horizon_dark_black

" Load light variant
colorscheme serene_horizon_light
```

### Advanced configuration

```lua
-- Configure with specific options
require('serene_horizon').setup({
  mode = 'dark',     -- 'dark' or 'light'
  variant = 'black'  -- 'original' or 'black' (for dark mode)
})

-- The theme automatically switches when you change background
vim.o.background = 'light' -- Switches to light mode
vim.o.background = 'dark'  -- Switches back to dark mode
```

## Color Palette

### Dark Mode (Original)
- Background: `#1a2b3c` - Deep oceanic blue
- Foreground: `#d9e2ec` - Soft cloud-like gray-blue
- Accent 1: `#4b7a8f` - Muted teal (keywords, functions)
- Accent 2: `#6d5b9a` - Lavender mist (strings, variables)
- Accent 3: `#5a8c72` - Sage green (numbers, booleans)

### Light Mode
- Background: `#f0f5fa` - Pale sky blue
- Foreground: `#2a3b4c` - Deep slate
- Accent 1: `#6a9ab0` - Light teal
- Accent 2: `#8f7ab8` - Soft lilac
- Accent 3: `#7ba992` - Pale sage

## Screenshots

*Coming soon*

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

## License

MIT License - see [LICENSE](LICENSE) for details.