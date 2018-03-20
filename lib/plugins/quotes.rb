module Quotes
  extend Discordrb::Commands::CommandContainer

  command(:trbmb) do |event|
    event.respond JSON.parse(RestClient.get('http://api.chew.pro/trbmb'))[0]
  end

  command(:acronym, min_args: 1, max_args: 1) do |event, acro|
    event.respond "#{acro} stands for: #{JSON.parse(RestClient.get(URI.escape("http://api.chew.pro/acronym/#{acro}")))['phrase']}"
  end
end
