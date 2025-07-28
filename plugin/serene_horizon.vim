" Serene Horizon color scheme plugin file
" This file provides autocommands for automatic theme switching

if exists('g:loaded_serene_horizon') || &cp
  finish
endif
let g:loaded_serene_horizon = 1

" Auto-switch between dark and light based on background setting
augroup SereneHorizonAuto
  autocmd!
  autocmd OptionSet background lua require('serene_horizon').setup({ mode = vim.o.background })
augroup END