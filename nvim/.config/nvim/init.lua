-- Entry point for neovim configuration
-- Load config modules in order

-- Core editor options (must come first)
require("config.options")

-- Bootstrap and configure lazy.nvim plugin manager
require("config.lazy")

-- Custom keybindings (after plugins so mappings don't conflict)
require("config.keymaps")
