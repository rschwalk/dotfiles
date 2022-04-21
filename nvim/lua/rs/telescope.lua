require('telescope').setup {
defaults = {

    prompt_prefix = "=> ",
    selection_caret = "->",
    path_display = { "smart" },
  },

    extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
local key_map = vim.api.nvim_set_keymap

key_map(
  "n",
  "<leader>ff",
  [[<Cmd>lua require'telescope.builtin'.find_files()<CR>]],
  { noremap = true, silent = true }
)
key_map(
  "n",
  "<leader>fb",
  [[<Cmd>lua require'telescope.builtin'.buffers()<CR>]],
  { noremap = true, silent = true }
)
key_map(
  "n",
  "<leader>fg",
  [[<Cmd>lua require'telescope.builtin'.live_grep()<CR>]],
  { noremap = true, silent = true }
)
key_map(
  "n",
  "<leader>fh",
  [[<Cmd>lua require'telescope.builtin'.help_tags()<CR>]],
  { noremap = true, silent = true }
)
