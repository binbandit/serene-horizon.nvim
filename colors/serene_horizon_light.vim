" Neovim color scheme loader for serene_horizon light variant

lua << EOF
local ok, serene_horizon = pcall(require, 'serene_horizon')
if ok then
  serene_horizon.setup({ mode = 'light', variant = 'original' })
else
  vim.notify('Error loading serene_horizon module: ' .. tostring(serene_horizon), vim.log.levels.ERROR)
end
EOF