module UserInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[uinfo userinfo]) do |event|
    event << 'User Info:'
    event << ''
    event << "Name\#Discrim: #{event.user.name}\##{event.user.discrim}"
    event << "User ID: #{event.user.id}"
    event << "Status: ``#{event.user.status}``"
    event << "User Nickname: `#{event.user.nick}`" unless event.user.nick.nil?
    event << "Currently Playing: `#{event.user.game}`" unless event.user.game.nil?
    event << "Your Avatar: https://cdn.discordapp.com/avatars/#{event.user.id}/#{event.user.avatar_id}.webp?size=1024"
  end
end
