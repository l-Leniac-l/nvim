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

-- return {
--   'neovim/nvim-lspconfig',
--   dependencies = {
--     'stevearc/conform.nvim',
--     'williamboman/mason.nvim',
--     'williamboman/mason-lspconfig.nvim',
--     'hrsh7th/cmp-nvim-lsp',
--     'hrsh7th/cmp-buffer',
--     'hrsh7th/cmp-path',
--     'hrsh7th/cmp-cmdline',
--     'hrsh7th/nvim-cmp',
--     'L3MON4D3/LuaSnip',
--     'saadparwaiz1/cmp_luasnip',
--     'j-hui/fidget.nvim',
--     'folke/neodev.nvim',
--   },
--   config = function()
--     require('neodev').setup {}
--     require('conform').setup {
--       formatters_by_ft = {
--         lua = { 'stylua', 'codespell' },
--         typescript = { 'biome', 'codespell' },
--         javascript = { 'biome', 'codespell' },
--         typescriptreact = { 'biome', 'codespell' },
--         javascriptreact = { 'biome', 'codespell' },
--         json = { 'biome', 'codespell' },
--         yaml = { 'yamlfmt', 'codespell' },
--       },
--       format_on_save = {
--         timeout_ms = 500,
--         lsp_format = 'fallback',
--       },
--     }
--
--     require('fidget').setup {}
--
--     local cmp = require 'cmp'
--     local cmp_lsp = require 'cmp_nvim_lsp'
--     local capabilities = vim.tbl_deep_extend(
--       'force',
--       {},
--       vim.lsp.protocol.make_client_capabilities(),
--       cmp_lsp.default_capabilities()
--     )
--
--     require('mason').setup()
--     require('mason-lspconfig').setup {
--       ensure_installed = {
--         'lua_ls',
--         'rust_analyzer',
--         'gopls',
--         'ts_ls',
--         'solargraph',
--       },
--       handlers = {
--         function(server_name)
--           require('lspconfig')[server_name].setup {
--             capabilities = capabilities,
--           }
--         end,
--         ['lua_ls'] = function()
--           require('lspconfig').lua_ls.setup {
--             capabilities = capabilities,
--             settings = {
--               Lua = {
--                 runtime = { version = 'Lua 5.1' },
--                 workspace = { checkThirdParty = false },
--                 telemetry = { enabled = false },
--               },
--             },
--           }
--         end,
--       },
--       automatic_installation = false,
--     }
--
--     local luasnip = require 'luasnip'
--
--     cmp.setup {
--       snippet = {
--         expand = function(args)
--           require('luasnip').lsp_expand(args.body)
--         end,
--       },
--       mapping = {
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<CR>'] = cmp.mapping.confirm {
--           behavior = cmp.ConfirmBehavior.Replace,
--           select = true,
--         },
--         ['<Down>'] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif luasnip.expand_or_locally_jumpable() then
--             luasnip.expand_or_jump()
--           else
--             fallback()
--           end
--         end, { 'i', 's' }),
--         ['<Up>'] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, { 'i', 's' }),
--       },
--       sources = cmp.config.sources {
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         {
--           { name = 'buffer' },
--         },
--       },
--     }
--
--     vim.diagnostic.config {
--       -- update_in_insert = true,
--       float = {
--         focusable = false,
--         style = 'minimal',
--         border = 'rounded',
--         source = true,
--         header = '',
--         prefix = '',
--       },
--     }
--   end,
-- }
