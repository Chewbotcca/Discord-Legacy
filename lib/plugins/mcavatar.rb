module MCavatar
  extend Discordrb::Commands::CommandContainer

  command(:mcavatar, min_args: 1, max_args: 1) do |event, mcuser|
    event.respond "Alright, here is a 3D full view of the player for the skin: #{mcuser}. https://visage.surgeplay.com/full/512/#{mcuser}.png"
  end
end
