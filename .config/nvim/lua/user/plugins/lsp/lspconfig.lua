-- load lspconfig plugin
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

-- load cmp_nvim_lsp plugin
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

local server_list = require("user.plugins.lsp.lsp-server-list").servers

-- enable keybinds only for when lsp server available
local keymap = vim.keymap
local on_attach = function(client, bufnr)
    -- keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
    keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- go to definition
    keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- rename
    keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- show references
    keymap.set("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts) -- show query for workspace symbole
    keymap.set("n", "<leader>ds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts) -- show document symbols
    keymap.set("n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- show signature help
    keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- open diagnostics
    keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- jump to next diagnostic in buffer
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

for _, server in ipairs(server_list) do
    local opts = {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    local require_ok, conf_opts = pcall(require, "user.plugins.lsp.ls-settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end

