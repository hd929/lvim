vim.diagnostic.config({ virtual_text = false })

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "shfmt", filetypes = { "sh", "zsh" } },
	{
		command = "prettierd",
		filetypes = { "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
})

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "eslint_d", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
})

require("user.lsp.languages.js-ts")
require("user.lsp.languages.emmet")
