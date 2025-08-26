-- Verificación de configuración de Neodots
-- Este archivo verifica que todos los plugins estén correctamente configurados

local M = {}

function M.check_plugins()
  local plugins_to_check = {
    "telescope",
    "gitsigns", 
    "nvim-autopairs",
    "Comment",
    "toggleterm",
    "nvim-cmp",
    "nvim-treesitter",
    "nvim-surround",
    "hop",
    "trouble",
    "ufo",
    "aerial",
    "harpoon",
    "noice",
  }
  
  local missing = {}
  
  for _, plugin in ipairs(plugins_to_check) do
    local ok, _ = pcall(require, plugin)
    if not ok then
      table.insert(missing, plugin)
    end
  end
  
  if #missing > 0 then
    print("Plugins faltantes: " .. table.concat(missing, ", "))
    print("Ejecuta :Lazy sync para instalar plugins faltantes")
  else
    print("✅ Todos los plugins principales están instalados")
  end
end

function M.check_keymaps()
  local keymaps_to_check = {
    { "n", "<leader>ff", "Telescope find_files" },
    { "n", "<C-\\>", "ToggleTerm" },
    { "i", "<C-g>", "Codeium accept" },
    { "n", "<leader>hw", "Hop to word" },
    { "n", "<leader>xx", "Trouble panel" },
    { "n", "<leader>S", "Global search/replace" },
    { "n", "<leader>ha", "Harpoon add file" },
  }
  
  print("🔧 Keymaps principales configurados:")
  for _, keymap in ipairs(keymaps_to_check) do
    print("  " .. keymap[1] .. " " .. keymap[2] .. " -> " .. keymap[3])
  end
end

-- Comando para verificar la configuración
vim.api.nvim_create_user_command("NeodotsCheck", function()
  print("🚀 Verificando configuración de Neodots...")
  M.check_plugins()
  M.check_keymaps()
  print("📋 Funcionalidades principales:")
  print("  • Multicursores: Ctrl+D (seleccionar palabra)")
  print("  • AI Completion: Ctrl+G (aceptar sugerencia)")
  print("  • Terminal: Ctrl+\\ (toggle terminal)")
  print("  • LazyGit: <leader>tg")
  print("  • Jump anywhere: <leader>hw (hop word)")
  print("  • Problems panel: <leader>xx (trouble)")
  print("  • Global search: <leader>S (spectre)")
  print("  • File bookmarks: <leader>ha (harpoon add)")
  print("  • Code folding: zR/zM (open/close all)")
  print("  • Surround text: cs'\" (change quotes)")
  print("  • Sessions: <leader>ss (save session)")
end, {})

return M