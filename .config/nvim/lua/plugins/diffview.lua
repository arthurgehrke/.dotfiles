require('diffview').setup({
  file_panel = {
    listing_style = 'tree',
    win_config = {
      position = 'bottom',
      height = 10,
    },
    tree_options = {
      flatten_dirs = false,
      folder_statuses = 'only_folded',
    },
  },
})
