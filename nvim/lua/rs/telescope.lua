-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

--require('telescope').setup {
--defaults = {
--
--    prompt_prefix = "=> ",
--    selection_caret = "->",
--    path_display = { "smart" },
--  },
--
--    extensions = {
--    fzf = {
--      fuzzy = true,                    -- false will only do exact matching
--      override_generic_sorter = true,  -- override the generic sorter
--      override_file_sorter = true,     -- override the file sorter
--      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                       -- the default case_mode is "smart_case"
--    }
--  }
--}
--require('telescope').load_extension('fzf')
--local key_map = vim.api.nvim_set_keymap
--
--key_map(
--  "n",
--  "<leader>ff",
--  [[<Cmd>lua require'telescope.builtin'.find_files()<CR>]],
--  { noremap = true, silent = true }
--)
--key_map(
--  "n",
--  "<leader>fb",
--  [[<Cmd>lua require'telescope.builtin'.buffers()<CR>]],
--  { noremap = true, silent = true }
--)
--key_map(
--  "n",
--  "<leader>fg",
--  [[<Cmd>lua require'telescope.builtin'.live_grep()<CR>]],
--  { noremap = true, silent = true }
--)
--key_map(
--  "n",
--  "<leader>fh",
--  [[<Cmd>lua require'telescope.builtin'.help_tags()<CR>]],
--  { noremap = true, silent = true }
--)
