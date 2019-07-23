local print = print
local tonumber = tonumber

module "src.cli_mode"

modes = {
  { name="root", label="HiZ (back to root menu)" },
  { name="ow", label="1-WIRE" },
  { name="uart", label="UART" },
  { name="i2c", label="I2C" },
  { name="spi", label="SPI" },
  { name="twow", label="2WIRE" },
  { name="thrw", label="3WIRE" },
  { name="lcd", label="LCD" },
}

prompt = [[
Please choose mode:
]]
for i=1,#modes do
  prompt = prompt .. i .. ". " .. modes[i].label .. "\n"
end
-- propmt = prompt .. "x. exit (don't change anything)\"
propmt = prompt .. "> "
not_implemented = { false,true,true,true,true,true,true,true }

function choose(num, context)
  local numnum = tonumber(num)
  if numnum and numnum >= 1 and numnum <= #modes then
    if not_implemented[numnum] then
      print( "Not implemented yet" )
      numnum = 1
    end
    context.switch_menu(modes[numnum].name)
  else
    print( "No such mode" )
  end
end

return {
  -- root CLI
  _reserved_words = {},
  _prompt = prompt,
  ["1"] = function(context) choose(1, context) end,
  ["2"] = function(context) choose(2, context) end,
  ["3"] = function(context) choose(3, context) end,
  ["4"] = function(context) choose(4, context) end,
  ["5"] = function(context) choose(5, context) end,
  ["6"] = function(context) choose(6, context) end,
  ["7"] = function(context) choose(7, context) end,
  ["8"] = function(context) choose(8, context) end,
}
