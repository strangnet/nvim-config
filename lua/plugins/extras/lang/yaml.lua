return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml-language-server", "yamllint", "yamlfmt" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = "yaml",
  },
}
