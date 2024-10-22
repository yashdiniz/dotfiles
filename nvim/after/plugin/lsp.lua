vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
lsp.ensure_installed({
  'ts_ls',
  'denols',
  'eslint',
  'lua_ls',
  'dockerls',
  'gopls',
  'graphql',
  'pyright',
  'rust_analyzer',
})

lsp.nvim_workspace()

-- lazy loading honza/vim-snippets snipmate format
require('luasnip.loaders.from_snipmate').lazy_load()

-- lsp-zero and lspconfig configurations are easy to translate
-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lsp.configure('gopls', {
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        unusedvariable = true,
        ununsedresult = true,
      },
      staticcheck = true,
    },
  },
})

-- prevents conflicts with between denols and ts_ls
lsp.configure('denols', {
  root_dir = function()
    return lsp.dir.find_first({ 'deno.json', 'deno.jsonc' })
  end
})
lsp.configure('ts_ls', {
  single_file_support = false,
  root_dir = function()
    return lsp.dir.find_first({ 'package.json' })
  end
})

lsp.on_attach(function(_, bufnr)
  local builtin = require('telescope.builtin')
  local wk = require('which-key')
  wk.add({
    { 'K',          vim.lsp.buf.hover,                     desc = 'Hover Documentation' },
    { '<c-k>',      vim.lsp.buf.signature_help,            desc = 'Signature Documentation' },
    { '[d',         vim.diagnostic.goto_prev,              desc = 'Go to previous diagnostic issue in buffer' },
    { ']d',         vim.diagnostic.goto_next,              desc = 'Go to next diagnostic issue in buffer' },

    { 'g',          group = 'LSP: Goto' },
    { 'gd',         vim.lsp.buf.definition,                desc = '[g]oto [d]efinition' },
    { 'gr',         builtin.lsp_references,                desc = '[g]oto [r]eferences' },
    { 'gD',         vim.lsp.buf.declaration,               desc = '[g]oto [D]eclaration' },
    { 'gI',         vim.lsp.buf.implementation,            desc = '[g]oto [I]mplementation' },

    { '<leader>e',  vim.diagnostic.open_float,             desc = 'LSP: Open diagnostics' },
    { '<leader>q',  vim.diagnostic.setloclist,             desc = 'LSP: Open diagnostics in loclist' },
    { '<leader>rn', vim.lsp.buf.rename,                    desc = 'LSP: [r]e[n]ame' },
    { '<leader>ca', vim.lsp.buf.code_action,               desc = 'LSP: [c]ode [a]ction' },
    { '<leader>D',  vim.lsp.buf.type_definition,           desc = 'LSP: Type [D]efinition' },
    { '<leader>ds', builtin.lsp_document_symbols,          desc = 'LSP: [d]ocument [s]ymbols' },

    { '<leader>w',  group = 'LSP: Workspace' },
    { '<leader>ws', builtin.lsp_dynamic_workspace_symbols, desc = '[w]orkspace [s]ymbols' },
    { '<leader>wa', vim.lsp.buf.add_workspace_folder,      desc = '[w]orkspace [a]dd folder' },
    { '<leader>wr', vim.lsp.buf.remove_workspace_folder,   desc = '[w]orkspace [r]emove folder' },
    {
      '<leader>wl',
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = '[w]orkspace [l]ist folders'
    },
  })

  -- Custom goimports function
  local function go_org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })

  -- Create an autocommand that runs `:Format` on save
  vim.api.nvim_create_augroup('lsp', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'lsp',
    callback = function()
      vim.cmd('Format')
    end,
  })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'lsp',
    callback = function()
      go_org_imports(1000)
    end,
  })
end)

lsp.setup()
