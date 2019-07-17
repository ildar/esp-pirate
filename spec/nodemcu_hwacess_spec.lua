local tango = require "tango"
local config = { address = os.getenv("TANGO_SERVER") }
local connect = tango.client["socket"].connect

describe("Tango client controlling NodeMCU", function()
  setup(function()
      client = connect(config)
      gpio_INPUT = client.gpio.INPUT()
    end)

  it("proves GPIO pins are in Flash boot state",
    function()
      client.gpio.mode(8, gpio_INPUT) -- GPIO15
      assert.is_equal( 0, client.gpio.read(8) )
      client.gpio.mode(3, gpio_INPUT) -- GPIO0
      assert.is_equal( 1, client.gpio.read(3) )
      client.gpio.mode(4, gpio_INPUT) -- GPIO2
      assert.is_equal( 1, client.gpio.read(4) )
    end)
end)
