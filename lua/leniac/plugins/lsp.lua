return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'stevearc/conform.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    'folke/neodev.nvim',
  },
  config = function()
    require('fidget').setup {}
    -- Neodev for neovim config
    require('neodev').setup {}

    -- Conform setup
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua', 'codespell' },
        typescript = { 'biome', 'codespell' },
        javascript = { 'biome', 'codespell' },
        typescriptreact = { 'biome', 'codespell' },
        javascriptreact = { 'biome', 'codespell' },
        json = { 'biome', 'codespell' },
        yaml = { 'yamlfmt', 'codespell' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }

    -- Mason setup
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'gopls',
        'ts_ls',
        'solargraph',
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = 'Lua 5.1' },
                workspace = { checkThirdParty = false },
                telemetry = { enabled = false },
              },
            },
          }
        end,
      },
      automatic_installation = false,
    }
  end,
}
