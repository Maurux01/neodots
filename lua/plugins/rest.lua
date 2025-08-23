-- REST client configuration

require("rest-nvim").setup({
  -- Register default filetypes
  filetypes = { "http", "rest" },
  -- Run request on same an opened vertical split
  result_split_in_place = false,
  -- Keep result buffer open
  stay_in_current_buffer = true,
  -- Skip SSL verification
  skip_ssl_verification = false,
  -- Encode URL before making request
  encode_url = true,
  -- Highlight request variables
  highlight = {
    enabled = true,
    timeout = 150,
  },
  -- Jump to request line on run
  jump_to_request = false,
  -- Format result body
  formatters = {
    json = "jq",
    html = function(body)
      if vim.fn.executable("tidy") == 1 then
        return vim.fn.system({"tidy", "-i", "-q", "--tidy-mark", "no"}, body)
      end
      return body
    end,
  },
  -- Run request in a floating window
  result = {
    -- toggle showing last request result
    toggle = nil, -- keymap to toggle
    -- results from different requests are separated by a line
    show_separator = true,
    -- show headers
    show_headers = true,
    -- show url
    show_url = true,
    -- show http status
    show_http_status = true,
    -- show result in a floating window
    show_in_float = true,
    -- float window options
    float_opts = {
      style = "minimal",
      border = "rounded",
      width = 80,
      height = 40,
    },
  },
})
