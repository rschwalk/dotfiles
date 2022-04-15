-- this really is compe.lua
-- setup compe, tab completion, and snippet support
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col "." - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

local lspconfig = require("lspconfig")

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  --mapping = {
  --  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --  ["<C-Space>"] = cmp.mapping.complete(),
  --  ["<C-e>"] = cmp.mapping.close(),
  --  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  --},
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  --formatting = {
  --  format = require("lspkind").cmp_format({
  --    with_text = true,
  --    menu = {
  --      nvim_lsp = "[LSP]",
  --    },
  --  }),
  --},
})



-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = {noremap = true, silent = true}

  map("n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  map("n", "gd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  map("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)

  -- These have a different style than above because I was fiddling
  -- around and never converted them. Instead of converting them
  -- now, I'm leaving them as they are for this article because this is
  -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  --vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  --vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

  --vim.cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  --vim.cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  --vim.cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  --vim.cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]

  --vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
  --vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
  --vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
  --vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
  --vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]

  -- tell nvim-cmp about our desired capabilities
  require("cmp_nvim_lsp").update_capabilities(capabilities)
end

-- Finally, let's initialize the Elixir language server

-- Replace the following with the path to your installation
local path_to_elixirls = vim.fn.expand("~/tools/elixir-ls/language_server.sh")

lspconfig.elixirls.setup({
    cmd = {path_to_elixirls},
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      elixirLS = {
        -- I choose to disable dialyzer for personal reasons, but
        -- I would suggest you also disable it unless you are well
        -- aquainted with dialzyer and know how to use it.
        dialyzerEnabled = false,
        -- I also choose to turn off the auto dep fetching feature.
        -- It often get's into a weird state that requires deleting
        -- the .elixir_ls directory and restarting your editor.
        fetchDeps = false
      }
    }
  })
-- compe tab maps
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
---- other compe maps
--vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { expr = true, noremap = true, silent = true })