-- Test script to verify Neovim configuration
-- This script can be run with: nvim --headless -c "set rtp+=." -c "luafile test_config.lua" -c "q"

print("🧪 Testing Neovim configuration...")

-- Test if options file loads correctly
local success, err = pcall(require, "config.options")
if success then
  print("✅ config.options loaded successfully")
else
  print("❌ config.options failed to load: " .. tostring(err))
end

-- Test if plugin files load correctly
local plugins_to_test = {
  "plugins.ui",
  "plugins.tools", 
  "plugins.lsp"
}

for _, plugin in ipairs(plugins_to_test) do
  local success, err = pcall(require, plugin)
  if success then
    print("✅ " .. plugin .. " loaded successfully")
    
    -- Additional check for alpha-nvim specific configuration
    if plugin == "plugins.ui" then
      local ui_plugins = require("plugins.ui")
      local has_alpha = false
      for _, p in ipairs(ui_plugins) do
        if p[1] == "goolord/alpha-nvim" then
          has_alpha = true
          break
        end
      end
      if has_alpha then
        print("✅ alpha-nvim plugin configured")
      else
        print("❌ alpha-nvim plugin missing")
      end
    end
    
  else
    print("❌ " .. plugin .. " failed to load: " .. tostring(err))
  end
end

-- Test if keymaps load correctly
local success, err = pcall(require, "config.keymaps")
if success then
  print("✅ config.keymaps loaded successfully")
else
  print("❌ config.keymaps failed to load: " .. tostring(err))
end

-- Test if autocmds load correctly
local success, err = pcall(require, "config.autocmds")
if success then
  print("✅ config.autocmds loaded successfully")
else
  print("❌ config.autocmds failed to load: " .. tostring(err))
end

print("🧪 Configuration test completed!")
