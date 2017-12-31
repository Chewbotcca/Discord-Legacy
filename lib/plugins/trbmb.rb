module TRBMB
  extend Discordrb::Commands::CommandContainer

  command(:trbmb) do |event|
    event.respond JSON.parse(RestClient.get('http://api.chew.pro/trbmb'))[0]
  end
end
