module UserInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[uinfo userinfo], max_args: 1) do |event, mention|
    begin
      if !mention.nil?
        userid = Bot.parse_mention(mention.to_s).id.to_i
        user = Bot.user(userid)
      else
        user = event.user
      end
      event.channel.send_embed do |e|
        e.title = if mention.nil?
                    'User Info for you!'
                  else
                    "User info for #{user.name}"
                  end

        begin
          RestClient.get("https://cdn.discordapp.com/avatars/#{user.id}/#{user.avatar_id}.gif?size=1024")
          e.thumbnail = { url: "https://cdn.discordapp.com/avatars/#{user.id}/#{user.avatar_id}.gif?size=1024".to_s }
        rescue RestClient::UnsupportedMediaType
          e.thumbnail = { url: "https://cdn.discordapp.com/avatars/#{user.id}/#{user.avatar_id}.webp?size=1024".to_s }
        end


        e.add_field(name: 'Name#Discrim', value: "#{user.name}\##{user.discrim}", inline: true)
        e.add_field(name: 'User ID', value: user.id, inline: true)

        case user.status.to_s
        when 'online'
          status = 'Online'
          e.color = '43B581'
        when 'idle'
          status = 'Idle'
          e.color = 'FAA61A'
        when 'dnd'
          status = 'Do Not Disturb'
          e.color = 'F04747'
        when 'offline'
          status = 'Offline'
          e.color = '747F8D'
        else
          status = user.status
          e.color = '747F8D'
        end

        e.add_field(name: 'Status', value: status, inline: true)

        begin
          e.add_field(name: 'Nickname', value: user.nick, inline: true) unless user.nick.nil?
        rescue StandardError
          puts 'whoopsiedaisy this guy dont got no nickname'
        end
        begin
          if user.game == 'Spotify'
            e.add_field(name: 'Currently Listening To', value: user.game, inline: true) unless user.game.nil?
          else
            e.add_field(name: 'Currently Playing', value: user.game, inline: true) unless user.game.nil?
          end
        rescue StandardError
          puts 'whoopsiedaisy this guy dont got no current playing'
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
