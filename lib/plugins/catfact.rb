module Catfact
  extend Discordrb::Commands::CommandContainer

  command(:catfact) do |event|
    event.respond JSON.parse(RestClient.get('https://catfact.ninja/fact'))['fact']
  end
end
