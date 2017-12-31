module Rip
  extend Discordrb::Commands::CommandContainer

  command(:rip, min_args: 1, max_args: 1) do |event, ripwho|
    event.respond "#{ripwho} got #rekt! http://ripme.xyz/#{ripwho}"
  end
end
