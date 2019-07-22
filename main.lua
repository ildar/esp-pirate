local RL = require 'readline'

-- load menus and sub-menus
local cli_root = require "src.cli_root"
local backend_nodemcu = require "src.backend_nodemcu"

-- TODO: maybe ignoredups=true
RL.set_options{ keeplines=1000, histfile='rl_history' }

local cmd
local current_cli = cli_root
RL.set_complete_list(current_cli._reserved_words)

-- prepare
backend = backend_nodemcu

while true do
  cmd = RL.readline(current_cli._prompt)
  if not cmd or cmd == "quit" then break end
  current_cli[cmd](backend)
end

RL.save_history()
