module Moderation
  extend Discordrb::Commands::CommandContainer

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
