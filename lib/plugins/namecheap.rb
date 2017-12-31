module Namecheap
  extend Discordrb::Commands::CommandContainer

  command(:namecheap, min_args: 1, max_args: 1, usage: 'In order to do a search, you must provide ONE word to search for.') do |event, lookup|
    event.respond "NameCheap Domain Search Results: https://www.namecheap.com/domains/registration/results.aspx?domain=#{lookup}"
  end
end
