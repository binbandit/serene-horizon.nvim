-- serene_horizon.lua
-- A soothing, eye-friendly Neovim theme inspired by a serene ocean horizon.
-- Colors are original, cool-toned for calm focus: deep blues, soft aquas, lavenders, and sages.
-- Designed to be visually stunning like a minimalist artwork, with balanced contrasts for readability.
-- Supports dark (two variants: black bg and oceanic bg) and light modes.
-- Comprehensive coverage: core editor, syntax, Treesitter, LSP, Telescope, NvimTree, GitSigns, etc.

local colors = {
  dark = {
    bg = "#1a2b3c",        -- Deep oceanic blue (original)
    fg = "#d9e2ec",        -- Soft cloud-like gray-blue
    accent1 = "#4c7b8f",   -- Muted teal (keywords, functions) - WCAG adjusted
    accent2 = "#7c6ca4",   -- Lavender mist (strings, variables) - WCAG adjusted
    accent3 = "#bcd1c6",   -- Sage green (numbers, booleans) - WCAG adjusted
    error = "#a26363",     -- Desaturated rose (errors) - WCAG adjusted
    warn = "#d8cabd",      -- Muted amber (warnings) - WCAG adjusted
    info = "#b3d2d2",      -- Soft cyan (info) - WCAG adjusted
    hint = "#c1d2b2",      -- Pale green (hints) - WCAG adjusted
    comment = "#c6cdd3",   -- Grayed lavender (comments) - WCAG adjusted
    dim = "#3e5a70",       -- Slightly lighter base (highlights, borders)
    bright = "#c0ced8",    -- Brighter fg variant - WCAG adjusted
    black_bg = "#000000",  -- Pure black for variant
  },
  light = {
    bg = "#f0f5fa",        -- Pale sky blue
    fg = "#2a3b4c",        -- Deep slate
    accent1 = "#496979",   -- Light teal - WCAG adjusted
    accent2 = "#6e5d8d",   -- Soft lilac - WCAG adjusted
    accent3 = "#4e6b5d",   -- Pale sage - WCAG adjusted
    error = "#835b5b",     -- Muted coral - WCAG adjusted
    warn = "#72634f",      -- Soft amber - WCAG adjusted
    info = "#4b6b6b",      -- Light cyan - WCAG adjusted
    hint = "#5c6a49",      -- Faint green - WCAG adjusted
    comment = "#5c6671",   -- Grayed blue - WCAG adjusted
    dim = "#d9e4ee",       -- Faint blue tint
    bright = "#1a2b3c",    -- Darker fg variant
  },
}

-- Function to generate highlight table based on mode and variant
local function get_highlights(mode, variant)
  local c = colors[mode]
  if mode == "dark" and variant == "black" then
    c.bg = c.black_bg
    -- Slight adjustments for black bg: lighten dims slightly for better contrast without strain
    c.dim = "#2a3e50"      -- Adjusted dim for visibility on black
    c.comment = "#6a7a8a"  -- Slightly brighter comment
  end

  return {
    -- Core Editor
    Normal = { fg = c.fg, bg = c.bg },
    NormalFloat = { fg = c.fg, bg = c.dim },
    FloatBorder = { fg = c.accent1, bg = c.dim },
    CursorLine = { bg = c.dim },
    CursorLineNr = { fg = c.bright, bold = true },
    LineNr = { fg = c.comment },
    SignColumn = { bg = c.bg },
    Folded = { fg = c.comment, bg = c.dim },
    FoldColumn = { fg = c.comment },
    VertSplit = { fg = c.dim },
    StatusLine = { fg = c.fg, bg = c.dim },
    StatusLineNC = { fg = c.comment, bg = c.dim },
    TabLine = { fg = c.fg, bg = c.dim },
    TabLineFill = { bg = c.bg },
    TabLineSel = { fg = c.bright, bg = c.accent1, bold = true },
    Pmenu = { fg = c.fg, bg = c.dim },
    PmenuSel = { fg = c.bright, bg = c.accent1 },
    PmenuSbar = { bg = c.dim },
    PmenuThumb = { bg = c.accent1 },
    Visual = { bg = c.dim },
    Search = { fg = c.bg, bg = c.accent3 },
    IncSearch = { fg = c.bg, bg = c.bright },
    MatchParen = { fg = c.accent2, bold = true },
    ColorColumn = { bg = c.dim },
    NonText = { fg = c.comment },
    Whitespace = { fg = c.comment },
    EndOfBuffer = { fg = c.comment },

    -- Syntax Highlighting
    Comment = { fg = c.comment, italic = true },
    Constant = { fg = c.accent3 },
    String = { fg = c.accent2 },
    Character = { fg = c.accent2 },
    Number = { fg = c.accent3 },
    Boolean = { fg = c.accent3 },
    Float = { fg = c.accent3 },
    Identifier = { fg = c.fg },
    Function = { fg = c.accent1 },
    Statement = { fg = c.accent1 },
    Conditional = { fg = c.accent1 },
    Repeat = { fg = c.accent1 },
    Label = { fg = c.accent1 },
    Operator = { fg = c.fg },
    Keyword = { fg = c.accent1 },
    Exception = { fg = c.error },
    PreProc = { fg = c.accent1 },
    Include = { fg = c.accent1 },
    Define = { fg = c.accent1 },
    Macro = { fg = c.accent1 },
    PreCondit = { fg = c.accent1 },
    Type = { fg = c.accent1 },
    StorageClass = { fg = c.accent1 },
    Structure = { fg = c.accent1 },
    Typedef = { fg = c.accent1 },
    Special = { fg = c.accent2 },
    SpecialChar = { fg = c.accent2 },
    Tag = { fg = c.accent1 },
    Delimiter = { fg = c.fg },
    SpecialComment = { fg = c.comment },
    Debug = { fg = c.warn },
    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.comment },
    Error = { fg = c.error, bold = true },
    Todo = { fg = c.info, bold = true },

    -- Treesitter (enhanced syntax)
    ["@variable"] = { fg = c.fg },
    ["@variable.builtin"] = { fg = c.accent1 },
    ["@variable.parameter"] = { fg = c.accent2 },
    ["@variable.member"] = { fg = c.fg },
    ["@constant"] = { fg = c.accent3 },
    ["@constant.builtin"] = { fg = c.accent3 },
    ["@constant.macro"] = { fg = c.accent1 },
    ["@module"] = { fg = c.accent1 },
    ["@module.builtin"] = { fg = c.accent1 },
    ["@label"] = { fg = c.accent1 },
    ["@string"] = { fg = c.accent2 },
    ["@string.documentation"] = { fg = c.comment },
    ["@string.regexp"] = { fg = c.accent2 },
    ["@string.escape"] = { fg = c.accent2 },
    ["@string.special"] = { fg = c.accent2 },
    ["@string.special.symbol"] = { fg = c.accent3 },
    ["@string.special.url"] = { fg = c.accent3, underline = true },
    ["@string.special.path"] = { fg = c.accent3 },
    ["@character"] = { fg = c.accent2 },
    ["@character.special"] = { fg = c.accent2 },
    ["@boolean"] = { fg = c.accent3 },
    ["@number"] = { fg = c.accent3 },
    ["@number.float"] = { fg = c.accent3 },
    ["@type"] = { fg = c.accent1 },
    ["@type.builtin"] = { fg = c.accent1 },
    ["@type.definition"] = { fg = c.accent1 },
    ["@attribute"] = { fg = c.accent1 },
    ["@attribute.builtin"] = { fg = c.accent1 },
    ["@property"] = { fg = c.fg },
    ["@function"] = { fg = c.accent1 },
    ["@function.builtin"] = { fg = c.accent1 },
    ["@function.call"] = { fg = c.accent1 },
    ["@function.macro"] = { fg = c.accent1 },
    ["@function.method"] = { fg = c.accent1 },
    ["@function.method.call"] = { fg = c.accent1 },
    ["@constructor"] = { fg = c.accent1 },
    ["@operator"] = { fg = c.fg },
    ["@keyword"] = { fg = c.accent1 },
    ["@keyword.coroutine"] = { fg = c.accent1 },
    ["@keyword.function"] = { fg = c.accent1 },
    ["@keyword.operator"] = { fg = c.accent1 },
    ["@keyword.import"] = { fg = c.accent1 },
    ["@keyword.type"] = { fg = c.accent1 },
    ["@keyword.modifier"] = { fg = c.accent1 },
    ["@keyword.repeat"] = { fg = c.accent1 },
    ["@keyword.return"] = { fg = c.accent1 },
    ["@keyword.debug"] = { fg = c.warn },
    ["@keyword.exception"] = { fg = c.error },
    ["@keyword.conditional"] = { fg = c.accent1 },
    ["@keyword.conditional.ternary"] = { fg = c.accent1 },
    ["@keyword.directive"] = { fg = c.accent1 },
    ["@keyword.directive.define"] = { fg = c.accent1 },
    ["@punctuation.delimiter"] = { fg = c.fg },
    ["@punctuation.bracket"] = { fg = c.fg },
    ["@punctuation.special"] = { fg = c.accent2 },
    ["@comment"] = { fg = c.comment, italic = true },
    ["@comment.documentation"] = { fg = c.comment },
    ["@comment.error"] = { fg = c.error },
    ["@comment.warning"] = { fg = c.warn },
    ["@comment.todo"] = { fg = c.info },
    ["@comment.note"] = { fg = c.hint },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.math"] = { fg = c.accent3 },
    ["@markup.environment"] = { fg = c.accent1 },
    ["@markup.environment.name"] = { fg = c.accent1 },
    ["@markup.raw"] = { fg = c.accent2 },
    ["@markup.raw.block"] = { fg = c.accent2 },
    ["@markup.link"] = { fg = c.accent3, underline = true },
    ["@markup.link.label"] = { fg = c.accent3 },
    ["@markup.link.url"] = { fg = c.accent3, underline = true },
    ["@markup.heading"] = { fg = c.bright, bold = true },
    ["@markup.list"] = { fg = c.accent1 },
    ["@markup.list.checked"] = { fg = c.hint },
    ["@markup.list.unchecked"] = { fg = c.warn },
    ["@markup.quote"] = { fg = c.comment, italic = true },
    ["@tag"] = { fg = c.accent1 },
    ["@tag.builtin"] = { fg = c.accent1 },
    ["@tag.attribute"] = { fg = c.accent2 },
    ["@tag.delimiter"] = { fg = c.fg },
    ["@diff.plus"] = { fg = c.hint },
    ["@diff.minus"] = { fg = c.error },
    ["@diff.delta"] = { fg = c.warn },
    ["@none"] = { fg = c.fg },

    -- LSP (Diagnostics)
    DiagnosticError = { fg = c.error },
    DiagnosticWarn = { fg = c.warn },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticVirtualTextError = { fg = c.error, bg = c.bg, italic = true },
    DiagnosticVirtualTextWarn = { fg = c.warn, bg = c.bg, italic = true },
    DiagnosticVirtualTextInfo = { fg = c.info, bg = c.bg, italic = true },
    DiagnosticVirtualTextHint = { fg = c.hint, bg = c.bg, italic = true },
    DiagnosticUnderlineError = { undercurl = true, sp = c.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warn },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },
    LspReferenceText = { bg = c.dim },
    LspReferenceRead = { bg = c.dim },
    LspReferenceWrite = { bg = c.dim },
    LspInlayHint = { fg = c.comment, italic = true },
    LspSignatureActiveParameter = { fg = c.bright, bold = true },

    -- Telescope
    TelescopeNormal = { fg = c.fg, bg = c.dim },
    TelescopeBorder = { fg = c.accent1, bg = c.dim },
    TelescopePromptBorder = { fg = c.accent2, bg = c.dim },
    TelescopeResultsBorder = { fg = c.accent1, bg = c.dim },
    TelescopePreviewBorder = { fg = c.accent1, bg = c.dim },
    TelescopeSelection = { fg = c.bright, bg = c.accent1 },
    TelescopeSelectionCaret = { fg = c.accent3 },
    TelescopeMultiSelection = { fg = c.accent2 },
    TelescopeTitle = { fg = c.bright, bold = true },
    TelescopePromptTitle = { fg = c.accent2, bold = true },
    TelescopeResultsTitle = { fg = c.accent1, bold = true },
    TelescopePreviewTitle = { fg = c.accent1, bold = true },

    -- NvimTree
    NvimTreeNormal = { fg = c.fg, bg = c.bg },
    NvimTreeFolderIcon = { fg = c.accent1 },
    NvimTreeFolderName = { fg = c.accent1 },
    NvimTreeOpenedFolderName = { fg = c.bright, bold = true },
    NvimTreeFileIcon = { fg = c.fg },
    NvimTreeExecFile = { fg = c.accent3, bold = true },
    NvimTreeOpenedFile = { fg = c.bright },
    NvimTreeRootFolder = { fg = c.accent2, bold = true },
    NvimTreeIndentMarker = { fg = c.comment },
    NvimTreeGitDirty = { fg = c.warn },
    NvimTreeGitStaged = { fg = c.hint },
    NvimTreeGitMerge = { fg = c.info },
    NvimTreeGitRenamed = { fg = c.accent3 },
    NvimTreeGitNew = { fg = c.hint },
    NvimTreeGitDeleted = { fg = c.error },
    NvimTreeWindowPicker = { fg = c.bright, bg = c.accent1, bold = true },

    -- GitSigns
    GitSignsAdd = { fg = c.hint },
    GitSignsChange = { fg = c.warn },
    GitSignsDelete = { fg = c.error },
    GitSignsTopdelete = { fg = c.error },
    GitSignsChangedelete = { fg = c.warn },

    -- Other Common Plugins
    -- CMP (Completion)
    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrMatch = { fg = c.bright, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.bright, underline = true },
    CmpItemKind = { fg = c.accent1 },
    CmpItemMenu = { fg = c.comment },

    -- Notify
    NotifyERRORBorder = { fg = c.error },
    NotifyWARNBorder = { fg = c.warn },
    NotifyINFOBorder = { fg = c.info },
    NotifyDEBUGBorder = { fg = c.comment },
    NotifyTRACEBorder = { fg = c.hint },
    NotifyERRORIcon = { fg = c.error },
    NotifyWARNIcon = { fg = c.warn },
    NotifyINFOIcon = { fg = c.info },
    NotifyDEBUGIcon = { fg = c.comment },
    NotifyTRACEIcon = { fg = c.hint },
    NotifyERRORTitle = { fg = c.error, bold = true },
    NotifyWARNTitle = { fg = c.warn, bold = true },
    NotifyINFOTitle = { fg = c.info, bold = true },
    NotifyDEBUGTitle = { fg = c.comment, bold = true },
    NotifyTRACETitle = { fg = c.hint, bold = true },

    -- IndentBlankline
    IblIndent = { fg = c.comment },
    IblWhitespace = { fg = c.comment },
    IblScope = { fg = c.accent1 },

    -- Noice (for cmdline, messages)
    NoiceCmdline = { fg = c.fg, bg = c.dim },
    NoiceCmdlineIcon = { fg = c.accent1 },
    NoiceCmdlinePopupBorder = { fg = c.accent2 },
    NoiceConfirmBorder = { fg = c.accent3 },

    -- Diffview
    DiffviewDiffAdd = { bg = c.hint },
    DiffviewDiffChange = { bg = c.warn },
    DiffviewDiffDelete = { bg = c.error },
    DiffviewFilePanelTitle = { fg = c.bright, bold = true },

    -- Lazy
    LazyNormal = { fg = c.fg, bg = c.dim },
    LazyButton = { fg = c.fg, bg = c.dim },
    LazyButtonActive = { fg = c.bright, bg = c.accent1 },
    LazyH1 = { fg = c.bright, bold = true },
  }
end

-- Theme setup function
local M = {}

M.setup = function(opts)
  opts = opts or {}
  local mode = opts.mode or (vim.o.background == "light" and "light" or "dark")
  local variant = opts.variant or "original"  -- "original" or "black" for dark

  if mode == "dark" and variant ~= "black" then
    variant = "original"
  end

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "serene_horizon_" .. mode .. "_" .. variant

  local highlights = get_highlights(mode, variant)
  for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

return M