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

local rustopts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require("rust-tools/executors").termopen,
        --inlay_hints = {
        --    show_parameter_hints = false,
        --    parameter_hints_prefix = "",
        --    other_hints_prefix = "",
        --},
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(rustopts)

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
mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    }),
   sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

vim.cmd [[ autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200) ]]

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = {noremap = true, silent = true}

  --map("n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  --map("n", "gd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  --map("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  --map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  --map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", map_opts)
  --map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  --map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  --map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)

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
local path_to_elixirls = vim.fn.expand("~/dev/tools/elixir-ls/language_server.sh")

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
  vim.cmd [[
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
  ]]
-- compe tab maps
--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
--vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
--vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
--vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
---- other compe maps
--vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { expr = true, noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { expr = true, noremap = true, silent = true })
