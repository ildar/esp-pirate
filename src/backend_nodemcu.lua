local tango = require "tango"
local print = print
local os_getenv = os.getenv

module "src.backend_nodemcu"

local config = {
  address = os_getenv("TANGO_SERVER"),
  _name = "NodeMCU through Tango RPC",
  _gpio_names = { [0]="GPIO16", "GPIO5", "GPIO4", "GPIO0", "GPIO2", "GPIO14", "GPIO12",
    "GPIO13", "GPIO15", "GPIO3", "GPIO1", "GPIO9", "GPIO10" },
}

function config.connect()
  -- FIXME close existing connection
  config.handle = tango.client["socket"].connect(config)
end

function config.is_online()
  -- FIXME: is network connection ok?
  return config.handle ~= nil
end

function config.version()
  local out = ""
  local majorVer, minorVer, devVer, chipid, flashid, flashsize, flashmode, flashspeed =
    config.handle.node.info()
  out = out .. "  Version: " .. majorVer .. "." .. minorVer .. "." .. devVer .. "\n"
  out = out .. "  Chip id: " .. chipid .. "\n"
  out = out .. "  Flash id: " .. flashid .. ", size: " .. flashsize .. 
    ", mode:" .. flashmode .. ", speed: " .. flashspeed .. "\n"
  out = out .. "Free heap: " .. config.handle.node.heap()
  return out
end

return config
