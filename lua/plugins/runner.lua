return {
  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>cr", "<cmd>RunCode<CR>", desc = "Run code" },
    },
    opts = {
      filetype = {
        lua = "lua",
        python = "python",
        javascript = "node",
        typescript = "ts-node",
        sh = "bash",
        go = "go run",
        rust = "cargo run",
        c = "gcc -o a.out % && ./a.out",
        cpp = "g++ -o a.out % && ./a.out",
      },
    },
  },
}