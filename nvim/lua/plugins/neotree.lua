return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false, -- Whether hidden by default
        show_hidden_count = true,
        hide_dotfiles = false, -- Whether to hide dotfiles
        hide_gitignored = false, -- Whether to hide gitignored files
        hide_by_name = {
          "node_modules",
          "thumbs.db",
        },
        never_show = {
          ".git",
          ".DS_Store",
          ".history",
        },
      },
    },
  },
}