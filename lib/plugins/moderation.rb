module Moderation
  extend Discordrb::Commands::CommandContainer

  command(:ban, required_permissions: [:ban_members], permission_message: 'imma keep it real with u chief! You need permission to ban members, come on bro we all do.', min_args: 1, max_args: 1, usage: 'please mention a user <3') do |event, mention, days = 0|
    if event.message.mentions.empty?
      event.respond 'Sorry, but you need to mention the person you want to ban'
      next
    end

    user = Bot.parse_mention(mention.to_s).id
    days = if days <= 0
             0
           elsif days > 0 && days <= 1
             1
           else
             7
           end
    begin
      event.server.ban(user.to_s, days)
    rescue Discordrb::Errors::NoPermission
      begin
        event.channel.send_embed do |embed|
          embed.title = 'Ouchie wowchie, I cannot ban!'
          embed.colour = 'CE4629'
          embed.description = "Well, I couldn't ban the guy. Possible causes:\n1) I don't have ban members perms.\n2) That user has a role higher or equal to mine.\nPlease make sure both are fixed and try again, thanks."
        end
      rescue Discordrb::Errors::NoPermission
        event.respond "Well, I couldn't ban the guy. Possible causes:\n1) I don't have ban members perms.\n2) That user has a role higher or equal to mine.\nPlease make sure both are fixed and try again, thanks."
      end
      next
    end
    begin
      dis = Bot.user(user).distinct
      event.channel.send_embed do |embed|
        embed.title = 'Somebody order a ban hammer?'
        embed.colour = 0x7d5eba
        embed.description = "That dude? Finna banned the guy. We don't need troublemakers here! Begone!\nYou just banned some DUDE (aka #{dis}) and now they can't rejoin until unbanned.\nHow much history got deleted? #{days} days..."

        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Beaner boi: #{dis}", icon_url: 'https://cdn.discordapp.com/embed/avatars/0.png')
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "<@#{user}> has been beaned, the past #{days} day(s) of messages from them have been deleted"
    end
  end

  command(:prune, min_args: 1, max_args: 1, required_permissions: [:manage_messages], permission_message: 'imma keep it real with u chief! You need permission to manage messages, come on bro we all do.') do |event, howmany|
    howmany = howmany.to_i
    begin
      event.message.delete
      event.channel.prune(howmany)
    rescue Discordrb::Errors::NoPermission
      event.respond "Come on dude, you can't just expect me to prune a channel without Manage Messages!!"
    end
    begin
      m = event.channel.send_embed do |embed|
        embed.title = 'Messages Successfully Pruned'
        embed.colour = 0xd084
        embed.description = ":wastebasket: Say goodbye to #{howmany} messages!"

        embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'This message will automatically delete in 5 seconds.')
      end
      sleep 5
      m.delete
    rescue Discordrb::Errors::NoPermission
      event.send_temporary_message(":wastebasket: Say goodbye to #{howmany} messages!", 5)
    end
  end
end
