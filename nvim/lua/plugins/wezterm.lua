return {
  { "mrjones2014/smart-splits.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      {
        "DrKJeff16/wezterm-types",
        lazy = true,
        version = false, -- Get the latest version
      },
    },
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" }, files = { ".wezterm.lua" } },
      },
    },
  },
}
