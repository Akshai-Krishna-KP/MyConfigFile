return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Neotree",
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,

    window = {
      position = "float",
      popup = {
        size = {
          height = "80%",
          width = "50%",
        },
        position = "50%",
      },
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        -- VS Code tree-style behavior inside the Neo-tree float
        ["<CR>"] = "open",
        ["<2-LeftMouse>"] = "open",
        ["<C-v>"] = "open_vsplit",
        ["<C-s>"] = "open_split",
        ["<C-t>"] = "open_tabnew",
        ["a"] = {
          "add",
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["<Del>"] = "delete",
        ["<BS>"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["y"] = "copy",
        ["q"] = "close_window",
        ["<Esc>"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
      },
    },

    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}