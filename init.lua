-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load individual plugin files that are properly structured as lazy.nvim plugins
local plugins = {}

-- Function to load plugin files
local function load_plugin_files()
  local plugin_files = {
    "dashboard",
    -- Add other plugin files that follow lazy.nvim format here
    -- For example: "telescope", "lsp", etc.
  }
  
  for _, plugin_name in ipairs(plugin_files) do
    local ok, plugin_spec = pcall(require, "lua.plugins." .. plugin_name)
    if ok and type(plugin_spec) == "table" then
      if plugin_spec[1] and plugin_spec[1].config then -- This is a lazy.nvim plugin spec
        table.insert(plugins, plugin_spec[1])
      elseif plugin_spec.config then -- This might be a single plugin spec
        table.insert(plugins, plugin_spec)
      end
    end
  end
end

-- Load the plugins
load_plugin_files()

-- Setup lazy.nvim with only the properly structured plugins
require("lazy").setup(plugins, {
  checker = {
    enabled = true,
    notify = true,
  },
  change_detection = {
    notify = false,
  },
})

-- Load regular Lua modules that are not plugins
-- require("lua.plugins.transparency") -- Commented out as it's not structured correctly
-- Add other regular Lua modules here as needed
