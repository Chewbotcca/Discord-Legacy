module ChannelInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[cinfo channelinfo], max_args: 1) do |event, id|
    channel = event.channel

    unless id.nil?
      begin
        channel = Bot.channel(id)
      rescue Discordrb::Errors::NoPermission
        event.respond "I am not able to retrieve that channel's stats. Am I on the server with that channel?"
        break
      end
    end
    begin
      event.channel.send_embed do |e|
        type = if channel.type.zero?
                 'Text'
               elsif channel.type == 1
                 'PM'
               elsif channel.type == 2
                 'Voice'
               elsif channel.type == 3
                 'Group PM'
               elsif channel.type == 4
                 'Category'
               else
                 channel.type
               end

        e.title = if type == 'Text'
                    "Channel Info for ##{channel.name}"
                  else
                    "Channel Info for #{channel.name}"
                  end

        e.add_field(name: 'ID', value: channel.id, inline: true)

        e.description = channel.topic if type == 'Text'

        e.add_field(name: 'Online Users', value: channel.users.count, inline: true) if type == 'Text'

        e.add_field(name: 'Users in Channel', value: channel.users.count, inline: true) if type == 'Voice'

        e.add_field(name: 'Type', value: type, inline: true)

        e.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Channel Created on')
        e.timestamp = channel.creation_time
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
