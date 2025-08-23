-- DAP (Debug Adapter Protocol) configuration
local M = {}

local dap = require("dap")
local dapui = require("dapui")

-- Auto open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Python debugger
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "attach",
    name = "Attach",
    port = 5678,
    host = "127.0.0.1",
  },
}

-- Node.js debugger
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.configurations.typescript = dap.configurations.javascript

-- C/C++ debugger
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = {},
    stopAtEntry = false,
    cwd = "${workspaceFolder}",
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
      {
        description = "Enable pretty-printing for gdb",
        text = "-enable-pretty-printing",
        ignoreFailures = true,
      },
    },
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

dap.configurations.c = dap.configurations.cpp

-- Go debugger
dap.adapters.dlv = {
  type = "executable",
  command = "dlv",
  args = { "dap", "-l", "127.0.0.1:38697" },
}

dap.configurations.go = {
  {
    type = "dlv",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "dlv",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "dlv",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- Lua debugger
dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input("Port: "))
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

-- Keymaps for debugging
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

return M
