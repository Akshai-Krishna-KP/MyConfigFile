return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant", -- "slant" | "slope" | "thick" | "thin"
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      diagnostics = "nvim_lsp",
    },
  },
}
