lvim.leader = "space"

lvim.keys.normal_mode["<C-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-q>"] = ":BufferKill<CR>"

-- Better window navigation
lvim.keys.normal_mode["<M-h>"] = "<C-w>h"
lvim.keys.normal_mode["<M-j>"] = "<C-w>j"
lvim.keys.normal_mode["<M-k>"] = "<C-w>k"
lvim.keys.normal_mode["<M-l>"] = "<C-w>l"

lvim.keys.normal_mode["gx"] = [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]]

lvim.keys.normal_mode["<tab>"] = "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<cr>"
lvim.keys.normal_mode["<s-tab>"] = "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>"

lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- Harpoon
lvim.builtin.which_key.mappings["m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" }
lvim.builtin.which_key.mappings["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" }
lvim.builtin.which_key.mappings[","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" }
lvim.builtin.which_key.mappings["s"] = { "<cmd>Telescope harpoon marks<cr>", "Search Files" }
lvim.builtin.which_key.mappings[";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" }

lvim.builtin.which_key.mappings["z"] = {"<cmd>ZenMode<cr>", "Zen Mode"}
