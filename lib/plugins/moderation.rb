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
  end
end
