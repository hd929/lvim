vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "sumneko_lua" })

local opts = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			hint = {
				enable = false,
			},
		},
	},
}

require("lvim.lsp.manager").setup("sumneko_lua", opts)
