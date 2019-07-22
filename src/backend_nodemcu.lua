local tango = require "tango"
local print = print
local os_getenv = os.getenv

module "src.backend_nodemcu"

local config = {
  address = os_getenv("TANGO_SERVER"),
  _name = "NodeMCU through Tango RPC",
}

function config.connect()
  -- FIXME close slave connection
  config.handle = tango.client["socket"].connect(config)
end

return config
