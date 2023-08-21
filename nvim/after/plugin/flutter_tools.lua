require("flutter-tools").setup {
    lsp = {
        background_color = { r = 19, g = 17, b = 24 },
    },
} -- use defaults

require("telescope").load_extension("flutter")
