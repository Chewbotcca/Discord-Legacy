module ServerInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[binfo botinfo], min_args: 1, max_args: 1) do |event, mention|
    id = Bot.parse_mention(mention.to_s).id.to_i

    begin
      data = JSON.parse(RestClient.get("https://discordbots.org/api/bots/#{id}"))
    rescue RestClient::NotFound
      event.respond 'Apperantly I got a 404 error. Does that bot exist?'
      break
    end

    error = data['error']

    begin
      if !error.nil?
        event.channel.send_embed do |e|
          e.title = 'Error'

          e.description = error

          e.color = 'FF0000'
        end
      else
        event.channel.send_embed do |e|
          e.title = 'Bot Information'

          author = "#{data['username']}\##{data['discriminator']}"

          certified = if data['certifiedBot']
                        'https://cdn.discordapp.com/emojis/392249976639455232.png?v=1'.to_s
                      else
                        "https://cdn.discordapp.com/avatars/#{id}/#{data['avatar']}.webp?size=1024".to_s
                      end

          e.author = { name: author, icon_url: certified }

          e.thumbnail = { url: "https://cdn.discordapp.com/avatars/#{id}/#{data['avatar']}.webp?size=1024".to_s }

          e.description = data['shortdesc']

          owners = []

          data['owners'].each do |meme|
            u = Bot.user(meme.to_i)
            owners[owners.length] = u.distinct.to_s
          end

          e.add_field(name: 'Bot Owners', value: owners.join("\n"), inline: true)
          e.add_field(name: 'Bot ID', value: id, inline: true)

          e.add_field(name: 'Server Count', value: data['server_count'].to_s, inline: true) unless data['server_count'].nil?

          e.add_field(name: 'Prefix', value: "`#{data['prefix']}`", inline: true)

          e.add_field(name: 'Library', value: data['lib'], inline: true)

          e.add_field(name: 'Points', value: [
            "This Month: #{data['monthlyPoints']}",
            "All Time: #{data['points']}"
          ].join("\n"), inline: true)

          tags = data['tags']

          if tags.empty?
            e.add_field(name: 'Tags', value: 'None', inline: true)
          else
            e.add_field(name: 'Tags', value: tags.join("\n").to_s, inline: true)
          end

          links = []
          links += ["[Bot Page](https://discordbots.org/bot/#{id})"]
          links += ["[Vote](https://discordbots.org/bot/#{id}/vote)"]
          links += ["[Invite](#{data['invite']})"] unless data['invite'] == ''
          links += ["[GitHub](#{data['github']})"] unless data['github'] == ''
          links += ["[Website](#{data['website']})"] unless data['website'] == ''
          links += ["[Support](http://discord.gg/#{data['support']})"] unless data['support'].nil?

          e.add_field(name: 'Links', value: links.join("\n"), inline: true)

          # e.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Bot added on')
          # e.timestamp = Date.parse(data['date']).to_s

          e.color = '00FF00'
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
