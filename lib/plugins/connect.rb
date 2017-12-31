module Connect
  extend Discordrb::Commands::CommandContainer

  command(:connect) do |event|
    channel = event.user.voice_channel
    next "You're not in any voice channel!" unless channel
    bot.voice_connect(channel)
    "Connected to voice channel: #{channel.name}."
  end
end
