require'nvim-treesitter.configs'.setup {
  ensure_installed = {"elixir", "lua"},
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
  },
}
