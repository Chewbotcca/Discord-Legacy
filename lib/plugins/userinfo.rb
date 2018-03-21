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
        e.thumbnail = { url: user.avatar_url.to_s }

        e.add_field(name: 'Name#Discrim', value: "#{user.name}\##{user.discrim}", inline: true)
        e.add_field(name: 'User ID', value: user.id, inline: true)
        e.add_field(name: 'Status', value: user.status, inline: true)
        begin
          e.add_field(name: 'Nickname', value: user.nick, inline: true) unless user.nick.nil?
        rescue StandardError
          puts 'whoopsiedaisy this guy dont got no nickname'
        end
        begin
          e.add_field(name: 'Currently Playing', value: user.game, inline: true) unless user.game.nil?
        rescue StandardError
          puts 'whoopsiedaisy this guy dont got no current playing'
        end
        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
