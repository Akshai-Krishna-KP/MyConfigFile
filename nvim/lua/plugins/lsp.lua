return {
  -- 1. lazydev.nvim: Configures Lua LSP for Neovim config editing (must load before lspconfig)
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- 2. LSP and Mason Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
    },

    config = function()
      -- Automatically attach keymaps when an LSP connects to a buffer
      -- Listen for built-in nvim events "LspAttach". nvim fires this events automatically when any language server connect to open buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        -- Group this autocommand under the name "UserLspConfig". By this cleas its old listeners
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        -- Function that executes when a event triggers
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          -- Helpful Mapped Actions
          map("gd", vim.lsp.buf.definition, "Goto Definition") -- Jumps your cursor directly to where the symbol under the cursor was defined
          map("gD", vim.lsp.buf.declaration, "Goto Declaration") -- Jumps to the symbol's declaration
          map("gr", vim.lsp.buf.references, "Goto References") -- Lists all places in your project where the symbol is referenced.
          map("K", vim.lsp.buf.hover, "Hover Documentation") -- Opens a floating documentation/type-signature window for the word under the cursor.
          map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol") -- Renames the symbol under the cursor across your entire project.
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action") -- Opens available LSP quick-fixes, import additions, or refactor options.
        end,
      })

      -- Automatically open diagnostic floating window when cursor stays over an error/warning
      vim.opt.updatetime = 300 -- Trigger CursorHold event faster (default is 4000ms)
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          })
        end,
      })

      -- Pull in blink.cmp capabilities if installed
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- Server-specific settings
      local servers = {
        -- Clangd : C/C++ Language server
        clangd = {
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--fallback-style=llvm",
          },
        },
        -- Python Language server
        basedpyright = {
          capabilities = capabilities,
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard", -- options: "off", "basic", "standard", "strict", "all"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        -- Ruff : Fast Python linter and code formatter
        ruff = {
          capabilities = capabilities,
          -- Disable hover in favor of Pyright/Basedpyright hover
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
        },
        -- Lua Languauge Server
        lua_ls = {
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                -- Ignore undefined global 'vim' warning (lazydev handles this)
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
              telemetry = { enable = false },
            },
          },
        },
        -- Bash Language Server
        bashls = {
          capabilities = capabilities,
          filetypes = { "sh", "bash" },
        },
      }

      -- Configure Mason and automatic installation
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          -- Default setup handler for all servers
          function(server_name)
            local server_opts = servers[server_name] or { capabilities = capabilities }
            require("lspconfig")[server_name].setup(server_opts)
          end,
        },
      })
    end,
  },
}
