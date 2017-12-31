module NameMC
  extend Discordrb::Commands::CommandContainer

  command(:namemc, min_args: 1, max_args: 1) do |event, mcsearch|
    event.respond "NameMC Search: http://namemc.com/s/#{mcsearch}"
  end
end
