return {
  'nvim-pack/nvim-spectre',
  keys = {
    { '<F4>', '<cmd>lua require("spectre").toggle()<CR>', mode = { 'n' } },
  },
  config = function()
    require('spectre').setup { is_block_ui_break = true }
  end,
}
