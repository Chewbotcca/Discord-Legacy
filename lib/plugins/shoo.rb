module Shoo
  extend Discordrb::Commands::CommandContainer

  command(:shoo) do |event|
    break unless event.user.id == CONFIG['owner_id']
    m = event.respond("I am shutting dowm, it's been a long run folks!")
    sleep 3
    m.delete
    exit
  end
end
