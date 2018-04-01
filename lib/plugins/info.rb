module Info
  extend Discordrb::Commands::CommandContainer

  command(:info, min_args: 0, max_args: 1) do |event, com|
    com = 'ewhewigfew' if com.nil?
    com.downcase!
    begin
      data = JSON.parse(RestClient.get("http://api.chew.pro/chewbotcca/discord/command/#{com}"))
      event.channel.send_embed do |e|
        e.color = '00FF00'

        if data['description'] == 'Invalid Command'
          e.title = 'SYSTEM ERROR'
          e.description = 'You failed, possible causes: You spelled the command wrong or that command doesn\'t exist. Use `%^help` to see commands.'
          e.color = 'FF0000'
        else
          e.title = "**Info For**: `%^#{com}`"
          e.description = data['description']
          e.add_field(name: 'Arguments', value: data['args'], inline: true)
          e.add_field(name: 'Aliases', value: data['alias'].join(' '), inline: true)
          e.add_field(name: 'Plugin', value: "[#{data['plugin']}](https://github.com/chewbotcca/discord/blob/master/lib/plugins/#{data['plugin'].downcase}.rb)", inline: true)
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
