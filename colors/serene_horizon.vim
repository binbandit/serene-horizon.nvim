" Neovim color scheme loader for serene_horizon
" Loads the dark original variant by default

lua << EOF
local ok, serene_horizon = pcall(require, 'serene_horizon')
if ok then
  serene_horizon.setup({ mode = 'dark', variant = 'original' })
else
  vim.notify('Error loading serene_horizon module: ' .. tostring(serene_horizon), vim.log.levels.ERROR)
end
EOF