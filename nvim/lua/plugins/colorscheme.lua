-- lua/plugins/colorscheme.lua
return {
  -- Get the tokyonight plugin as the default
  -- keep the priority 1000 so it load fast and won't cause any flickering
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,

    -- function attached to theme itself
    -- used to swtich between theme
    config = function()
      local themes = {
        "kanagawa-wave",
        "tokyonight-night",
        "tokyonight-storm",
        "catppuccin-mocha",
        "catppuccin-latte",
        "kanagawa-dragon",
        "gruvbox",
        "onedark",
        "habamax",
      }

      local current_idx = 1

      -- Function that set the themes based on index given
      local function set_theme(idx)
        current_idx = idx
        local theme = themes[current_idx]
        local ok, _ = pcall(vim.cmd.colorscheme, theme)
        if ok then
          vim.notify("Colorscheme: " .. theme, vim.log.levels.INFO)
        else
          vim.notify("Failed to load: " .. theme, vim.log.levels.ERROR)
        end
      end

      -- Define the Keymap for changing the Colortheme
      vim.keymap.set("n", "<C-.>", function()
        local next_idx = (current_idx % #themes) + 1
        set_theme(next_idx)
      end, { desc = "Next Colorscheme" })

      vim.keymap.set("n", "<C-,>", function()
        local prev_idx = (current_idx - 2 + #themes) % #themes + 1
        set_theme(prev_idx)
      end, { desc = "Previous Colorscheme" })

      -- Start with the default theme
      set_theme(1)
    end,
  },

  -- Other colorschemes (no config needed here)
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
  { "navarasu/onedark.nvim", lazy = false, priority = 1000 },
}