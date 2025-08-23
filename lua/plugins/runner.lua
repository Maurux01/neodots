-- Code runner configuration

require("code_runner").setup({
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
})
