local present, null_ls = pcall(require, "null-ls")

if not present then
   return
end

local b = null_ls.builtins

local sources = {
  -- go
  b.diagnostics.golangci_lint,

  -- Lua
  b.formatting.stylua,

  -- Markdown
  b.diagnostics.markdownlint,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

null_ls.setup {
   debug = true,
   sources = sources,
}
