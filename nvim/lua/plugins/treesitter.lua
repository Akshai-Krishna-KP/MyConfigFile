return {
  "nvim-treesitter/nvim-treesitter",
  
  -- Instruct Lazy.nvim to run :TSUpdate whenever plugins is installed or updated
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  
  config = function()
    -- load the configuration module provided by treesitter into local lua variable
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "python",
      },

      -- Install missing parser async
      sync_install = false,

      -- Auto downloaded parser that are not yet available
      auto_install = true,

      -- Overide nvim default highlight with AST-based highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}