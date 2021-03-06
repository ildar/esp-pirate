local RL = require 'readline'

-- load menus and sub-menus
local backend_nodemcu = require "src.backend_nodemcu"
local menus = {
  root = require "src.cli_root",
  mode = require "src.cli_mode",
}

-- TODO: maybe ignoredups=true
RL.set_options{ keeplines=1000, histfile='rl_history' }

local cmd
local current_cli = menus.root

-- prepare
app_context = {
  backend = backend_nodemcu,
  switch_menu = function(name)
    current_cli = menus[name]
    RL.set_complete_list(current_cli._reserved_words)
  end,
}

app_context.switch_menu("root")
while true do
  cmd = RL.readline(current_cli._prompt)
  if not cmd or cmd == "quit" then break end
  if type(current_cli[cmd]) == "function" then
    current_cli[cmd](app_context)
  else
    print( "wrong command" )
  end
end

RL.save_history()
