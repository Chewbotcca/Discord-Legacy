module UserInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[uinfo userinfo]) do |event|
    event.channel.send_embed do |e|
      e.title = 'User Info for you!'
      e.thumbnail = { url: "https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.webp?size=1024".to_s }

      e.add_field(name: 'Name#Discrim', value: "#{event.user.name}\##{event.user.discrim}", inline: true)
      e.add_field(name: 'User ID:', value: event.user.id, inline: true)
      e.add_field(name: 'Status', value: event.user.status, inline: true)
      e.add_field(name: 'Nickname', value: event.user.nick, inline: true) unless event.user.nick.nil?
      e.add_field(name: 'Currently Playing:', value: event.user.game, inline: true) unless event.user.game.nil?
      e.color = '00FF00'
    end
  end
end
