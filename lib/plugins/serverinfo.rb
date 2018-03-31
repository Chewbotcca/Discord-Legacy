module ServerInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[sinfo serverinfo], min_args: 0, max_args: 1) do |event, id|
    server = event.server

    unless id.nil?
      begin
        server = Bot.server(id)
      rescue Discordrb::Errors::NoPermission
        event.respond "I am not on that server and are therefore unable to view that server's stats. Try getting them to add me by sending them this invite link: <http://bit.ly/Chewbotcca>"
        break
      end
    end

    if event.channel.pm?
      event.respond "You silly meme, you can't do SERVERinfo in a private message!!! haha, trying to bamboozle, who got bamboozled NOW? But seriously, try running this on a server. Better yet invite me to one: <http://bit.ly/Chewbotcca>"
      next
    end
    begin
      message = event.channel.send_embed do |e|
        e.title = 'Server Information'

        e.author = { name: server.name, icon_url: "https://cdn.discordapp.com/icons/#{server.id}/#{server.icon_id}.png?size=1024" }

        e.thumbnail = { url: "https://cdn.discordapp.com/icons/#{server.id}/#{server.icon_id}.png?size=1024".to_s }

        e.add_field(name: 'Server Owner', value: server.owner.mention, inline: true)
        e.add_field(name: 'Server ID', value: server.id, inline: true)

        region = if server.region == 'vip-amsterdam'
                   '<:region_amsterdam:426902668871467008> <:vip_region:426902668909477898> Amsterdam'
                 elsif server.region == 'brazil'
                   '<:region_brazil:426902668561219605> Brazil'
                 elsif server.region == 'eu-central'
                   '<:region_eu:426902669110673408> Central Europe'
                 elsif server.region == 'hongkong'
                   '<:region_hongkong:426902668636585985> Hong Kong'
                 elsif server.region == 'japan'
                   '<:region_japan:426902668578127884> Japan'
                 elsif server.region == 'russia'
                   '<:region_russia:426902668859015169> Russia'
                 elsif server.region == 'singapore'
                   '<:region_singapore:426902668951158784> Singapore'
                 elsif server.region == 'sydney'
                   '<:region_sydney:426902668934643722> Sydney'
                 elsif server.region == 'us-central'
                   '<:region_us:426902668900827146> US Central'
                 elsif server.region == 'us-east'
                   '<:region_us:426902668900827146> US East'
                 elsif server.region == 'vip-us-east'
                   '<:region_us:426902668900827146> <:vip_region:426902668909477898> US East'
                 elsif server.region == 'us-south'
                   '<:region_us:426902668900827146> US South'
                 elsif server.region == 'us-west'
                   '<:region_us:426902668900827146> US West'
                 elsif server.region == 'vip-us-west'
                   '<:region_us:426902668900827146> <:vip_region:426902668909477898> US West'
                 elsif server.region == 'eu-west'
                   '<:region_eu:426902669110673408> Western Europe'
                 else
                   message.guild.region
                 end

        e.add_field(name: 'Server Region', value: region, inline: true)

        botos = 0
        server.members.each do |meme|
          botos += 1 if meme.bot_account?
        end

        e.add_field(name: 'Member Count', value: [
          "Total - #{server.members.count}",
          "Bots - #{botos}",
          "Users - #{server.members.count - botos}"
        ].join("\n"), inline: true)
        e.add_field(name: 'Channel Count', value: [
          "Total: #{server.channels.count}",
          "Text: #{server.text_channels.count}",
          "Voice: #{server.voice_channels.count}",
          "Categories: #{server.channels.count - server.text_channels.count - server.voice_channels.count}"
        ].join("\n"), inline: true)

        roles = []
        server.roles.each { |name| roles[roles.length] = name.name }
        roles -= ['@everyone']

        if roles.length > 50
          e.add_field(name: "Roles - #{server.roles.count}", value: "**(First 50)**: #{roles.join(', ')[0..50]}", inline: true)
        else
          e.add_field(name: "Roles - #{server.roles.count}", value: roles.join(', ').to_s, inline: true)
        end

        e.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Server Created on')
        e.timestamp = server.creation_time

        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
