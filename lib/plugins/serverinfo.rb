module ServerInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[sinfo serverinfo]) do |event|
    event.channel.send_embed do |e|
      e.title = 'Server Information'

      e.thumbnail = { url: "https://cdn.discordapp.com/icons/#{event.server.id}/#{event.server.icon_id}.png?size=1024".to_s }

      e.add_field(name: 'Server Name:', value: event.server.name, inline: true)
      e.add_field(name: 'Server ID:', value: event.server.id, inline: true)
      e.add_field(name: 'Server Region:', value: event.server.region, inline: true)
      e.add_field(name: 'Server Owner', value: "#{event.server.owner.name}\##{event.server.owner.discrim}", inline: true)
      e.add_field(name: 'Member Count:', value: event.server.members.count, inline: true)
      e.add_field(name: 'Total Channel Count', value: event.server.channels.count, inline: true)
      e.add_field(name: 'Text Channels', value: event.server.text_channels.count, inline: true)
      e.add_field(name: 'Voice Channels', value: event.server.voice_channels.count, inline: true)
      e.add_field(name: 'Roles', value: event.server.roles.count, inline: true)
      e.color = '00FF00'
    end
  end
end
