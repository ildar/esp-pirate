local pairs = pairs
local print = print
local tostring = tostring
local s_format = string.format

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

function info(backend)
  print( [[ESP pirate v0.1]] )
  print( [[https://github.com/ildar/esp-pirate/]] )
  print( "Backend: "..backend._name )
  print( "Backend address: "..(backend.address or "nil") )
  print( "Backend connected: "..tostring(backend.handle) )
  if not backend.handle then return end
  print( "Backend version: " )
  print( backend.version() )
  print( "*----------*" )
  print( "Pinstates:" )
  for p = 0,12 do
    -- FIXME: cannot determine if a pin is in INPUT/OUTPUT/... mode?
    local st = backend.handle.gpio.read(p)
    print( s_format("%2d.%-6s: %d",p, backend._gpio_names[p], st ) )
  end
end

function connect(backend)
  return backend.connect()
end

-- init code
reserved_words = {
  "i", "connect",
}
for _,v in pairs(cli_common_reserved_words) do
  reserved_words[#reserved_words + 1] = v
end

return {
  -- some common parts also placed here
  cli_common_reserved_words = cli_common_reserved_words,
  cli_common_help = cli_common_help,
  -- root CLI
  _reserved_words = reserved_words,
  _prompt = "HiZ> ",
  ["help"] = help, ["?"] = help,
  ["i"] = info,
  ["connect"] = connect,
}
