return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    require('telescope').setup {}

    pcall(require('telescope').load_extension, 'fzf')

    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set(
      'n',
      '<leader>gf',
      builtin.git_files,
      { desc = '[G]it [F]iles' }
    )
    vim.keymap.set(
      'n',
      '<leader>fb',
      builtin.buffers,
      { desc = '[F]ind [B]uffers' }
    )
    vim.keymap.set(
      'n',
      '<leader>ff',
      builtin.find_files,
      { desc = '[F]ind [F]iles' }
    )
    vim.keymap.set(
      'n',
      '<leader>fg',
      builtin.live_grep,
      { desc = '[F]ind Files Live [G]rep' }
    )
    vim.keymap.set(
      'n',
      '<leader>fh',
      builtin.help_tags,
      { desc = '[F]ind [H]elp' }
    )
    vim.keymap.set(
      'n',
      '<leader>fw',
      builtin.grep_string,
      { desc = '[F]ind Current [W]ord' }
    )
    vim.keymap.set(
      'n',
      '<leader>fr',
      builtin.resume,
      { desc = '[F]ind [R]resume' }
    )

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
  end,
}
