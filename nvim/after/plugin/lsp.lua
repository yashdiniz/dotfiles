vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
lsp.ensure_installed({
  'tsserver',
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

lsp.on_attach(function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, remap = false, desc = desc })
  end

  nmap('<leader>e', vim.diagnostic.open_float, 'Open diagnostics')
  nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics in loclist')
  nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic issue in buffer')
  nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic issue in buffer')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Custom goimports function
  local function go_org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
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
  vim.api.nvim_create_augroup('lsp', {clear = true})
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
