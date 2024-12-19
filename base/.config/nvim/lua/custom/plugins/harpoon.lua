return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      -- REQUIRED
      local harpoon = require 'harpoon'
      harpoon:setup()
      -- REQUIRED

      local map = function(keys, desc, func, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = 'HPN: ' .. desc })
      end

      -- Basic Setup
      map('<leader>aa', '[A]dd File', function()
        harpoon:list():add()
      end)

      map('<leader>ac', '[C]lear', function()
        harpoon:list():clear()
      end)

      map('<leader>aq', '1', function()
        harpoon:list():select(1)
      end)
      map('<leader>aw', '2', function()
        harpoon:list():select(2)
      end)
      map('<leader>ae', '3', function()
        harpoon:list():select(3)
      end)
      map('<leader>ar', '4', function()
        harpoon:list():select(4)
      end)

      -- Telescope Configuration
      -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#telescope
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      map('<leader>al', '[L]ist Files', function()
        toggle_telescope(harpoon:list())
      end)
    end,
  },
}
