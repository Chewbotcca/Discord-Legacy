module Help
  extend Discordrb::Commands::CommandContainer

  command(%i[help commands]) do |event|
    event.respond 'You can find all my commands here: <https://discord.chewbotcca.co/commands>'
  end
end