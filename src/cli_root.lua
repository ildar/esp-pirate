local print = print

module "src.cli_root"

-- some common parts also placed here
local cli_common_reserved_words = {
  "?", "help", "quit",
}

local cli_common_help = [[
RTFS :D
]]

function help()
  print( cli_common_help )
end

return {
  -- some common parts also placed here
  cli_common_reserved_words = cli_common_reserved_words,
  cli_common_help = cli_common_help,
  -- root CLI
  _reserved_words = cli_common_reserved_words,
  _prompt = "HiZ> ",
  ["help"] = help, ["?"] = help,
}