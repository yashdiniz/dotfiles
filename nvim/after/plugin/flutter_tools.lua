require("flutter-tools").setup {
    lsp = {
        background_color = { r = 19, g = 17, b = 24 },
    },
    debugger = {
        enabled = true,
        register_configurations = function(_)
            require("dap").configurations.dart = {}
        end
    },
} -- use defaults

require("telescope").load_extension("flutter")
