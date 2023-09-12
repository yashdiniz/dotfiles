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
  local builtin = require('telescope.builtin')
  local wk = require('which-key')
  wk.register({
    -- See `:help K` for why this keymap
    ['K'] = { vim.lsp.buf.hover, 'Hover Documentation' },
    ['<c-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
    ['[d'] = { vim.diagnostic.goto_prev, 'Go to previous diagnostic issue in buffer' },
    [']d'] = { vim.diagnostic.goto_next, 'Go to next diagnostic issue in buffer' },
    g = {
      name = 'LSP: Goto',
      d = { vim.lsp.buf.definition, '[g]oto [d]efinition' },
      r = { builtin.lsp_references, '[g]oto [r]eferences' },
      D = { vim.lsp.buf.declaration, '[g]oto [D]eclaration' },
      I = { vim.lsp.buf.implementation, '[g]oto [I]mplementation' },
    },
    ['<leader>'] = {
      e = { vim.diagnostic.open_float, 'LSP: Open diagnostics' },
      q = { vim.diagnostic.setloclist, 'LSP: Open diagnostics in loclist' },

      rn = { vim.lsp.buf.rename, 'LSP: [r]e[n]ame' },
      ca = { vim.lsp.buf.code_action, 'LSP: [c]ode [a]ction' },

      D = { vim.lsp.buf.type_definition, 'LSP: Type [D]efinition' },
      ds = { builtin.lsp_document_symbols, 'LSP: [d]ocument [s]ymbols' },

      w = {
        name = 'LSP: Workspace',
        s = { builtin.lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols' },
        a = { vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd folder' },
        r = { vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove folder' },
        l = { function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[w]orkspace [l]ist folders' }
      },
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
