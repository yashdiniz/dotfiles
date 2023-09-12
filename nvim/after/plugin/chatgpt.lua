local home = vim.fn.expand('$HOME')
require('chatgpt').setup({
    api_key_cmd = "gpg --decrypt " .. home .. "/oai-secret.env.gpg",
    -- openai_params = {
    --     model = 'gpt-4',
    -- },
})
