return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb", "rust-analyzer", "taplo" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    ft = "rust",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "rust_analyzer" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", "RustHoverActions", { buffer = buffer, desc = "Hover Actions (Rust)" })
              vim.keymap.set("n", "<leader>cR", "RustCodeActionGroup", { buffer = buffer, desc = "Code Action (Rust)" })
            end
          end)
          local rust_opts = {
            server = vim.tbl_deep_extend("force", {}, opts, opts.server or {}),
            tools = { -- rust-tools options
              -- options same as lsp hover / vim.lsp.util.open_floating_preview()
              hover_actions = {
                -- whether the hover action window gets automatically focused
                auto_focus = true,
              },
            },
          }
          require("rust-tools").setup(rust_opts)
          return true
        end,
      },
    },
  },

  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
}
