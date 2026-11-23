return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = { auto_close = true },
        },
      },
      image = {
        -- image
      },
      dashboard = {
        preset = {
          --   pick = function(cmd, opts)
          --     return LazyVim.pick(cmd, opts)()
          --   end,
          --   header = [[
          --             -- Custom ASCII art here --
          --             ]],
          keys = {
            { icon = "󰷈 ", key = ".", desc = "Scratch Buffer", action = ":lua Snacks.scratch()" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
