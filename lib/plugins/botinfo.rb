module ServerInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[binfo botinfo], min_args: 1, max_args: 1) do |event, mention|
    id = Bot.parse_mention(mention.to_s).id.to_i

    begin
      boat = DBL.loadbot(id)
    rescue DBLRuby::Errors::InvalidBot
      event.respond 'That bot isn\'t on the list. Please pick a bot on the list, thanks, appreciate ya.'
      break
    end

    error = boat.data['error']

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

          author = "#{boat.username}\##{boat.tag}"

          certified = if boat.certified?
                        'https://cdn.discordapp.com/emojis/392249976639455232.png?v=1'.to_s
                      else
                        boat.avatar_img
                      end

          e.author = { name: author, icon_url: certified }

          e.thumbnail = { url: boat.avatar_img.to_s }

          e.description = boat.shortdesc

          owners = []

          boat.owners.each do |meme|
            u = Bot.user(meme.to_i)
            owners[owners.length] = u.distinct.to_s
          end

          e.add_field(name: 'Bot Owners', value: owners.join("\n"), inline: true)
          e.add_field(name: 'Bot ID', value: id, inline: true)

          e.add_field(name: 'Server Count', value: boat.server.to_s, inline: true) unless boat.server.nil?

          e.add_field(name: 'Prefix', value: "`#{boat.prefix}`", inline: true)

          e.add_field(name: 'Library', value: boat.lib, inline: true)

          e.add_field(name: 'Points', value: [
            "This Month: #{boat.monthlyvotes}",
            "All Time: #{boat.votes}"
          ].join("\n"), inline: true)

          tags = boat.tags

          if tags.empty?
            e.add_field(name: 'Tags', value: 'None', inline: true)
          else
            e.add_field(name: 'Tags', value: tags.join("\n").to_s, inline: true)
          end

          links = []
          links += ["[Bot Page](https://discordbots.org/bot/#{id})"]
          links += ["[Vote](https://discordbots.org/bot/#{id}/vote)"]
          links += ["[Invite](#{boat.invite})"] unless boat.invite == ''
          links += ["[GitHub](#{boat.github})"] unless boat.github == ''
          links += ["[Website](#{boat.website})"] unless boat.website == ''
          links += ["[Support](#{boat.support_link})"] unless boat.support.nil?

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
