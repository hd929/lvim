lvim.plugins = {
	-- Navigation plugins
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				magic_window = true,
				auto_resize_height = false,
				preview = {
					auto_preview = false,
					show_title = true,
					delay_syntax = 50,
					wrap = false,
				},
				func_map = {
					tab = "t",
					openc = "o",
					drop = "O",
					split = "s",
					vsplit = "v",
					stoggleup = "M",
					stoggledown = "m",
					stogglevm = "m",
					filterr = "f",
					filter = "F",
					prevhist = "<",
					nexthist = ">",
					sclear = "c",
					ptoggleauto = "p",
					ptogglemode = "P",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},

	-- LSP
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"Exafunction/codeium.vim",
		config = function()
			local opts = { expr = true, silent = true }

			vim.keymap.set("i", "<M-a>", function()
				return vim.fn["codeium#Accept"]()
			end, opts)
			vim.keymap.set("i", "<M-.>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, opts)
			vim.keymap.set("i", "<M-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, opts)
			vim.keymap.set("i", "<M-x>", function()
				return vim.fn["codeium#Clear"]()
			end, opts)
		end,
	},
	{ "jose-elias-alvarez/typescript.nvim" },

	-- General
	"tpope/vim-surround",
	"opalmay/vim-smoothie",
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"monaqa/dial.nvim",
		event = "BufRead",
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},

	-- Git
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
	},
	-- Treesitter
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = {
					-- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"method",
					},
				},
			})
		end,
	},
	"nvim-treesitter/nvim-treesitter-textobjects",

	-- Colorschemes
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue or blue
					RRGGBBAA = false, -- #RRGGBBAA hex codes
					AARRGGBB = false, -- 0xAARRGGBB hex codes
					rgb_fn = false, -- CSS rgb() and rgba() functions
					hsl_fn = false, -- CSS hsl() and hsla() functions
					css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "background", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = false, -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
					virtualtext = "■",
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})

			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = {
					"*.css",
				},
				callback = function()
					require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
				end,
			})
		end,
	},
	{
		"svrana/neosolarized.nvim",
		dependencies = {
			"tjdevries/colorbuddy.nvim",
		},
	},
	{
		"rktjmp/lush.nvim",
	},

	-- LSP
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 100, -- Width of the floating window
				height = 25, -- Height of the floating window
				border = { "", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border characters of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
			})
		end,
	},

	-- RUST
	{
		"simrat39/rust-tools.nvim",
		config = function()
			-- local lsp_installer_servers = require("nvim-lsp-installer.servers")
			-- local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					-- hover_with_actions = true,
					-- options same as lsp hover / vim.lsp.util.open_floating_preview()
					hover_actions = {
						-- the border that is used for the hover window
						-- see vim.api.nvim_open_win()
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},

						-- whether the hover action window gets automatically focused
						-- default: false
						auto_focus = true,
					},
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					on_init = require("lvim.lsp").common_on_init,
					on_attach = function(client, bufnr)
						require("lvim.lsp").common_on_attach(client, bufnr)
						local rt = require("rust-tools")
						-- Hover actions
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
		ft = { "rust", "rs" },
	},

	-- Extra
	"folke/zen-mode.nvim",
	{
		"is0n/jaq-nvim",
		config = function()
			require("jaq-nvim").setup({
				-- Commands used with 'Jaq'
				cmds = {
					-- Default UI used (see `Usage` for options)
					default = "term",

					-- Uses external commands such as 'g++' and 'cargo'
					external = {
						typescript = "deno run %",
						javascript = "node %",
						-- markdown = "glow %",
						python = "python %",
						-- rust = "rustc % && ./$fileBase && rm $fileBase",
						rust = "cargo run",
						cpp = "g++ % -o $fileBase && ./$fileBase",
						go = "go run %",
						sh = "sh %",
					},

					-- Uses internal commands such as 'source' and 'luafile'
					internal = {
						-- lua = "luafile %",
						-- vim = "source %",
					},
				},

				behavior = {
					-- Default type
					default = "terminal",

					-- Start in insert mode
					startinsert = true,

					-- Use `wincmd p` on startup
					wincmd = false,

					-- Auto-save files
					autosave = false,
				},

				-- UI settings
				ui = {
					-- Floating Window / FTerm settings
					float = {
						-- Floating window border (see ':h nvim_open_win')
						border = "none",

						-- Num from `0 - 1` for measurements
						height = 0.8,
						width = 0.8,
						x = 0.5,
						y = 0.5,

						-- Highlight group for floating window/border (see ':h winhl')
						border_hl = "FloatBorder",
						float_hl = "Normal",

						-- Floating Window Transparency (see ':h winblend')
						blend = 0,
					},

					terminal = {
						-- Position of terminal
						position = "bot",

						-- Open the terminal without line numbers
						line_no = false,

						-- Size of terminal
						size = 10,
					},
				},
			})

			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "<M-r>", ":silent only | Jaq<CR>", opts)
		end,
	},
	-- {
	--   "j-hui/fidget.nvim",
	--   config = function()
	--     require("fidget").setup()
	--   end,
	-- },

	-- "MunifTanjim/nui.nvim",
	-- {
	--   "folke/noice.nvim",
	--   event = "VimEnter",
	--   config = function()
	--     require("noice").setup()
	--   end,
	-- },

	{
		"mg979/vim-visual-multi",
		config = function()
			vim.cmd([[
                let g:VM_maps = {}
                let g:VM_mouse_mappings = 1
                ]])
		end,
	},
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},

	{
		"christianchiarulli/harpoon",
		config = function()
			local _, telescope = pcall(require, "telescope")
			if not _ then
				return
			end

			telescope.load_extension("harpoon")
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({
				show = true,
				show_in_active_only = false,
				set_highlights = true,
				folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
				max_lines = false, -- disables if no. of lines in buffer exceeds this
				handle = {
					text = " ",
					color = "#292e42",
					cterm = nil,
					-- highlight = "CursorColumn",
					hide_if_all_visible = false, -- Hides handle if all lines are visible
				},
				marks = {
					Cursor = {
						-- text = "•",
						text = "─",
						priority = 0,
						color = "#1a1b26",
						cterm = nil,
						-- highlight = "Normal",
					},
					Search = {
						text = { "-", "=" },
						priority = 1,
						color = nil,
						cterm = nil,
						highlight = "Search",
					},
					Error = {
						text = { "-", "=" },
						priority = 2,
						color = nil,
						cterm = nil,
						highlight = "DiagnosticVirtualTextError",
					},
					Warn = {
						text = { "-", "=" },
						priority = 3,
						color = nil,
						cterm = nil,
						highlight = "DiagnosticVirtualTextWarn",
					},
					Info = {
						text = { "-", "=" },
						priority = 4,
						color = nil,
						cterm = nil,
						highlight = "DiagnosticVirtualTextInfo",
					},
					Hint = {
						text = { "-", "=" },
						priority = 5,
						color = nil,
						cterm = nil,
						highlight = "DiagnosticVirtualTextHint",
					},
					Misc = {
						text = { "-", "=" },
						priority = 6,
						color = nil,
						cterm = nil,
						highlight = "Normal",
					},
					GitAdd = {
						text = "┆",
						priority = 7,
						color = nil,
						cterm = nil,
						highlight = "GitSignsAdd",
					},
					GitChange = {
						text = "┆",
						priority = 7,
						color = nil,
						cterm = nil,
						highlight = "GitSignsChange",
					},
					GitDelete = {
						text = "▁",
						priority = 7,
						color = nil,
						cterm = nil,
						highlight = "GitSignsDelete",
					},
				},
				excluded_buftypes = {
					"terminal",
				},
				excluded_filetypes = {
					"prompt",
					"TelescopePrompt",
					"noice",
				},
				autocmd = {
					render = {
						"BufWinEnter",
						"TabEnter",
						"TermEnter",
						"WinEnter",
						"CmdwinLeave",
						"TextChanged",
						"VimResized",
						"WinScrolled",
					},
					clear = {
						"BufWinLeave",
						"TabLeave",
						"TermLeave",
						"WinLeave",
					},
				},
				handlers = {
					cursor = true,
					diagnostic = false,
					gitsigns = false, -- Requires gitsigns
					handle = true,
					search = false, -- Requires hlslens
				},
			})
		end,
	},
}
