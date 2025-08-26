-- Test the Neovim configuration by simulating the startup process
local function test_config()
  print("Testing Neovim configuration...")
  
  -- Simulate the init.lua loading process
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  
  -- Load options
  local ok, options = pcall(require, "config.options")
  if not ok then
    print("❌ config.options not found")
    return false
  end
  
  -- Try to load the LSP plugins configuration
  local ok, lsp_plugins = pcall(require, "plugins.lsp")
  if not ok then
    print("❌ plugins.lsp not found:", lsp_plugins)
    return false
  end
  
  print("✅ Configuration files loaded successfully")
  
  -- Test if we can access the mason-lspconfig setup without errors
  local function test_mason_lspconfig_setup()
    -- This simulates the config function in the LSP plugin
    local capabilities = {} -- Mock capabilities for testing
    
    local mason_ok, mason = pcall(require, "mason")
    if not mason_ok then
      return false, "mason.nvim not available"
    end
    
    local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_ok then
      return false, "mason-lspconfig.nvim not available"
    end
    
    -- Test the setup that was causing the error
    mason.setup()
    
    local success, err = pcall(function()
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = false,
      })
    end)
    
    if not success then
      return false, "mason-lspconfig setup failed: " .. tostring(err)
    end
    
    return true
  end
  
  local success, err = test_mason_lspconfig_setup()
  if not success then
    print("❌ mason-lspconfig test failed:", err)
    return false
  end
  
  print("✅ mason-lspconfig setup test passed")
  return true
end

-- Run the test
if test_config() then
  print("🎉 Configuration test completed successfully!")
  print("The 'enable' field nil error should be resolved.")
else
  print("💥 Configuration test failed!")
end
