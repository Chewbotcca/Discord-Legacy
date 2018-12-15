module Feedback
  extend Discordrb::Commands::CommandContainer

  command(:feedback, min_args: 1) do |event, *feedback|
    feedback = feedback.join(' ')
    event.bot.channel(429_282_806_175_236_126).send_embed do |embed|
      embed.title = 'New Feedback!'
      embed.colour = '6166A8'
      embed.description = feedback.to_s
      embed.timestamp = Time.now

      begin
        RestClient.get("https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.gif?size=1024")
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: event.user.distinct.to_s, icon_url: "https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.gif?size=1024")
      rescue RestClient::UnsupportedMediaType
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: event.user.distinct.to_s, icon_url: "https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.webp?size=1024")
      end

      embed.add_field(name: 'User ID', value: event.user.id.to_s, inline: true)
      if event.channel.pm?
        embed.add_field(name: 'Server', value: 'Sent from a PM', inline: true)
      else
        embed.add_field(name: 'Server', value: "Name: #{event.server.name}\n#{event.server.id}", inline: true)
      end
    end
    event.respond 'I have sucessfully sent the feedback! Feel free to see it on the help server with `%^invite`'
  end
end
