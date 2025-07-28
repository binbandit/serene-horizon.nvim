#!/usr/bin/env lua

-- WCAG Color Contrast Checker for Serene Horizon Theme
-- This script checks all color combinations in the theme for WCAG compliance
-- and suggests accessible alternatives when needed

-- Convert hex to RGB
local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1, 2), 16) / 255,
    g = tonumber(hex:sub(3, 4), 16) / 255,
    b = tonumber(hex:sub(5, 6), 16) / 255,
  }
end

-- Convert RGB to hex
local function rgb_to_hex(rgb)
  local function to_hex(val)
    return string.format("%02x", math.floor(val * 255 + 0.5))
  end
  return "#" .. to_hex(rgb.r) .. to_hex(rgb.g) .. to_hex(rgb.b)
end

-- Calculate relative luminance
local function get_luminance(rgb)
  local function adjust(val)
    if val <= 0.03928 then
      return val / 12.92
    else
      return ((val + 0.055) / 1.055) ^ 2.4
    end
  end
  
  local r = adjust(rgb.r)
  local g = adjust(rgb.g)
  local b = adjust(rgb.b)
  
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

-- Calculate contrast ratio between two colors
local function get_contrast_ratio(color1, color2)
  local rgb1 = hex_to_rgb(color1)
  local rgb2 = hex_to_rgb(color2)
  
  local lum1 = get_luminance(rgb1)
  local lum2 = get_luminance(rgb2)
  
  local lighter = math.max(lum1, lum2)
  local darker = math.min(lum1, lum2)
  
  return (lighter + 0.05) / (darker + 0.05)
end

-- Adjust color to meet minimum contrast ratio
local function adjust_color_for_contrast(fg_hex, bg_hex, min_ratio)
  local bg_rgb = hex_to_rgb(bg_hex)
  local fg_rgb = hex_to_rgb(fg_hex)
  local bg_lum = get_luminance(bg_rgb)
  
  local current_ratio = get_contrast_ratio(fg_hex, bg_hex)
  if current_ratio >= min_ratio then
    return fg_hex
  end
  
  -- Determine if we need to lighten or darken the foreground
  local fg_lum = get_luminance(fg_rgb)
  local should_lighten = bg_lum < 0.5
  
  -- Binary search for the right adjustment
  local low = 0
  local high = 1
  local best_rgb = fg_rgb
  
  for _ = 1, 20 do
    local mid = (low + high) / 2
    local test_rgb = {
      r = should_lighten and math.min(1, fg_rgb.r + mid * (1 - fg_rgb.r)) or fg_rgb.r * (1 - mid),
      g = should_lighten and math.min(1, fg_rgb.g + mid * (1 - fg_rgb.g)) or fg_rgb.g * (1 - mid),
      b = should_lighten and math.min(1, fg_rgb.b + mid * (1 - fg_rgb.b)) or fg_rgb.b * (1 - mid),
    }
    
    local test_hex = rgb_to_hex(test_rgb)
    local test_ratio = get_contrast_ratio(test_hex, bg_hex)
    
    if test_ratio >= min_ratio then
      high = mid
      best_rgb = test_rgb
    else
      low = mid
    end
  end
  
  return rgb_to_hex(best_rgb)
end

-- Load the theme colors
local colors = {
  dark = {
    bg = "#1a2b3c",
    fg = "#d9e2ec",
    accent1 = "#4b7a8f",
    accent2 = "#6d5b9a",
    accent3 = "#5a8c72",
    error = "#9e5b5b",
    warn = "#9e7a5b",
    info = "#5b9e9e",
    hint = "#7a9e5b",
    comment = "#7a8a9a",
    dim = "#3e5a70",
    bright = "#a0b5c5",
    black_bg = "#000000",
  },
  light = {
    bg = "#f0f5fa",
    fg = "#2a3b4c",
    accent1 = "#6a9ab0",
    accent2 = "#8f7ab8",
    accent3 = "#7ba992",
    error = "#b07a7a",
    warn = "#b09a7a",
    info = "#7ab0b0",
    hint = "#9ab07a",
    comment = "#8a9aaa",
    dim = "#d9e4ee",
    bright = "#1a2b3c",
  },
}

-- WCAG Standards
-- AA: 4.5:1 for normal text, 3:1 for large text
-- AAA: 7:1 for normal text, 4.5:1 for large text
local WCAG_AA_NORMAL = 4.5
local WCAG_AA_LARGE = 3.0

print("=== WCAG Color Contrast Analysis for Serene Horizon ===\n")

local function check_theme_colors(mode_name, mode_colors)
  print(string.format("Checking %s mode:", mode_name))
  print(string.rep("-", 60))
  
  local updated_colors = {}
  for k, v in pairs(mode_colors) do
    updated_colors[k] = v
  end
  
  -- Check each foreground color against backgrounds
  local fg_colors = {"fg", "accent1", "accent2", "accent3", "error", "warn", "info", "hint", "comment", "bright"}
  local bg_colors = {"bg", "dim"}
  
  -- Special handling for black background variant
  if mode_name == "dark" then
    table.insert(bg_colors, "black_bg")
  end
  
  local issues_found = false
  
  for _, bg_key in ipairs(bg_colors) do
    local bg = mode_colors[bg_key]
    if bg then
      print(string.format("\nAgainst %s (%s):", bg_key, bg))
      
      for _, fg_key in ipairs(fg_colors) do
        local fg = mode_colors[fg_key]
        if fg and fg ~= bg then
          local ratio = get_contrast_ratio(fg, bg)
          local passes_aa = ratio >= WCAG_AA_NORMAL
          local status = passes_aa and "✓" or "✗"
          
          if not passes_aa then
            issues_found = true
            local new_color = adjust_color_for_contrast(fg, bg, WCAG_AA_NORMAL)
            updated_colors[fg_key] = new_color
            print(string.format("  %s %s on %s: %.2f:1 → %s (%.2f:1)", 
              status, fg_key, bg_key, ratio, new_color, get_contrast_ratio(new_color, bg)))
          else
            print(string.format("  %s %s on %s: %.2f:1", status, fg_key, bg_key, ratio))
          end
        end
      end
    end
  end
  
  if not issues_found then
    print("\n✓ All colors pass WCAG AA standards!")
  end
  
  return updated_colors
end

-- Check both themes
local updated_dark = check_theme_colors("dark", colors.dark)
local updated_light = check_theme_colors("light", colors.light)

-- Generate updated theme file content
print("\n\n=== Updated Colors for WCAG Compliance ===\n")

print("Dark mode colors:")
for k, v in pairs(updated_dark) do
  if v ~= colors.dark[k] then
    print(string.format('    %s = "%s",  -- was %s', k, v, colors.dark[k]))
  end
end

print("\nLight mode colors:")
for k, v in pairs(updated_light) do
  if v ~= colors.light[k] then
    print(string.format('    %s = "%s",  -- was %s', k, v, colors.light[k]))
  end
end

-- Write updated colors to a file
local output = string.format([[
-- Updated color definitions with WCAG AA compliance
local colors = {
  dark = {
    bg = "%s",        -- Deep oceanic blue (original)
    fg = "%s",        -- Soft cloud-like gray-blue
    accent1 = "%s",   -- Muted teal (keywords, functions)
    accent2 = "%s",   -- Lavender mist (strings, variables)
    accent3 = "%s",   -- Sage green (numbers, booleans)
    error = "%s",     -- Desaturated rose (errors)
    warn = "%s",      -- Muted amber (warnings, adjusted for calm)
    info = "%s",      -- Soft cyan (info)
    hint = "%s",      -- Pale green (hints)
    comment = "%s",   -- Grayed lavender (comments, dimmed for subtlety)
    dim = "%s",       -- Slightly lighter base (highlights, borders)
    bright = "%s",    -- Brighter fg variant (for pops without strain)
    black_bg = "%s",  -- Pure black for variant
  },
  light = {
    bg = "%s",        -- Pale sky blue
    fg = "%s",        -- Deep slate
    accent1 = "%s",   -- Light teal
    accent2 = "%s",   -- Soft lilac
    accent3 = "%s",   -- Pale sage
    error = "%s",     -- Muted coral
    warn = "%s",      -- Soft amber
    info = "%s",      -- Light cyan
    hint = "%s",      -- Faint green
    comment = "%s",   -- Grayed blue
    dim = "%s",       -- Faint blue tint
    bright = "%s",    -- Darker fg variant
  },
}
]],
  updated_dark.bg, updated_dark.fg, updated_dark.accent1, updated_dark.accent2,
  updated_dark.accent3, updated_dark.error, updated_dark.warn, updated_dark.info,
  updated_dark.hint, updated_dark.comment, updated_dark.dim, updated_dark.bright,
  updated_dark.black_bg,
  updated_light.bg, updated_light.fg, updated_light.accent1, updated_light.accent2,
  updated_light.accent3, updated_light.error, updated_light.warn, updated_light.info,
  updated_light.hint, updated_light.comment, updated_light.dim, updated_light.bright
)

local file = io.open("wcag_compliant_colors.lua", "w")
if file then
  file:write(output)
  file:close()
  print("\n\nUpdated colors written to wcag_compliant_colors.lua")
end