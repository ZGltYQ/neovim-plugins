---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    local null_ls = require("null-ls")
    local builtins = null_ls.builtins

    opts.on_attach = function(client, bufnr)
      vim.keymap.set("n", "<A-e>", function()
        vim.lsp.buf.format({
          async = true,
          filter = function(c)
            return c.name == "null-ls"
          end,
        })
      end, { buffer = bufnr, desc = "ESLint/Prettier fix" })
    end

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- ESLint
      require("none-ls.diagnostics.eslint_d"),
      require("none-ls.formatting.eslint_d"),

      -- Stylelint via null-ls builtins
      builtins.diagnostics.stylelint,
      builtins.formatting.stylelint,

      -- Prettier
      builtins.formatting.prettierd.with({
        filetypes = { "json", "markdown", "yaml", "html" },
      }),
    })
  end,
}

