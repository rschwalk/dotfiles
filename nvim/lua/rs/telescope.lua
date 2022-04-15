require('telescope').setup {
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

--nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

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