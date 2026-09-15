-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for comments
-- Normal mode: Toggle comment for the current line
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle Comment" })

-- Visual mode: Toggle comment for the selected block
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle Comment" })

-- Keymaps for neo-tree
-- Toggle the file explorer
vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle float<CR>", { desc = "Explorer: Toggle Neo-tree" })
vim.keymap.set("n", "<C-S-E>", "<cmd>Neotree toggle float<CR>", { desc = "Explorer: Toggle Neo-tree" })

-- Reveal active file in explorer
vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal float<CR>", { desc = "Explorer: Focus Active File" })

-- Close floating explorer with Esc if focused
vim.keymap.set("n", "<leader>w", "<cmd>Neotree close<CR>", { desc = "Explorer: Close Neo-tree" })

-- Bufferline Keymaps
vim.keymap.set("n", "<C-w>", "<cmd>BufferLineCycleNext<CR>", { desc = "Buffer: Next Tab" })
vim.keymap.set("n", "<C-q>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer: Prev Tab" })
vim.keymap.set("n", "<C-d>", "<cmd>bdelete<CR>", { desc = "Buffer: Close Active Tab" })
