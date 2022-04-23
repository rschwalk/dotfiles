local o = vim.o
-- Better copy & paste
-- When you want to paste large blocks of code into vim, press F2 before you
-- paste. At the bottom you should see ``-- INSERT (paste) --``.
o.pastetoggle = "<F6>"

local key_map = vim.api.nvim_set_keymap
key_map(
  "n",
  "<leader>t",
  ":vsplit term://fish<CR>",
  { noremap = true, silent = true }
)
