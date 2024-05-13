local home = vim.fn.expand('$HOME')

-- Default config https://github.com/olimorris/codecompanion.nvim?tab=readme-ov-file#wrench-configuration
require("codecompanion").setup({
    adapters = {
        anthropic = require("codecompanion.adapters").use("anthropic", {
            env = {
                api_key = "cmd:gpg --decrypt " .. home .. "/anthropic-secret.env.gpg",
            },
        }),
        openai = require("codecompanion.adapters").use("openai", {
            env = {
                api_key = "cmd:gpg --decrypt " .. home .. "/oai-secret.env.gpg",
            },
        }),
    },
    strategies = {
        chat = "anthropic",
        inline = "anthropic"
    },
})
