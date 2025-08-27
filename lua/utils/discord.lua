-- Discord Rich Presence utilities
local M = {}

-- Toggle Discord presence
function M.toggle()
  local presence = require("presence")
  if presence.is_connected then
    presence:cancel()
    vim.notify("Discord Rich Presence disabled", vim.log.levels.INFO)
  else
    presence:update()
    vim.notify("Discord Rich Presence enabled", vim.log.levels.INFO)
  end
end

-- Show status
function M.status()
  local presence = require("presence")
  local status = presence.is_connected and "Connected" or "Disconnected"
  vim.notify("Discord Rich Presence: " .. status, vim.log.levels.INFO)
end

-- Custom update with project info
function M.update_with_project()
  local presence = require("presence")
  local cwd = vim.fn.getcwd()
  local project_name = vim.fn.fnamemodify(cwd, ":t")
  
  presence:update({
    workspace_text = "Working on " .. project_name,
  })
end

return M