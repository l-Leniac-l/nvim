return {
  'stevearc/oil.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    require('mini.icons').setup {}
    require('oil').setup {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        {
          'icon',
        },
      },
    }
    vim.keymap.set('n', '<leader>pv', '<cmd>Oil<cr>')
  end,
}
