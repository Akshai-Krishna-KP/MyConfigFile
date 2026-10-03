local opt = vim.opt

-- Line Number
opt.number = true -- Show absolute line number on current line
opt.relativenumber = true -- Show relativenumber

-- Indentation & Tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Override Global indentation for some files
local indent_groups = vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })
local function set_two_indent()
  vim.bo.tabstop = 2
  vim.bo.softtabstop = 2
  vim.bo.shiftwidth = 2
  vim.bo.expandtab = true -- Fixed: must be boolean, not 2
end

vim.api.nvim_create_autocmd("FileType", {
  group = indent_groups,
  pattern = {
    "lua",
    "html",
    "css",
    "json",
  },
  callback = set_two_indent,
})

-- Search Behavior
opt.ignorecase = true      -- Ignore case when searching
opt.smartcase = true       -- Switch to case-sensitive if search contains a capital letter
opt.hlsearch = true        -- Highlight search matches
opt.incsearch = true       -- Show search results incrementally as you type

-- Enable mouse support
vim.opt.mouse = "a"

-- Sync Nvim with default clipboard
vim.opt.clipboard = "unnamedplus"


-- Smart Code Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- Re-evaluate folding after Treesitter attaches to the buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})

