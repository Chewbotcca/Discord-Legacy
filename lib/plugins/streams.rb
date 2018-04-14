module Streams
  extend Discordrb::Commands::CommandContainer

  command(:mixer, min_args: 1, max_args: 1) do |event, user|
    error = nil
    begin
      parse = JSON.parse(RestClient.get("https://mixer.com/api/v1/channels/#{user}"))
    rescue StandardError
      error = 'User not found!'
    end
    name = parse['token']
    online = if parse['online']
               'Currently Streaming!'
             else
               'Currently Offline'
             end
    followers = parse['numFollowers'].to_s
    avatar = parse['user']['avatarUrl']
    begin
      if !error.nil?
        event.channel.send_embed do |embed|
          embed.title = "Mixer info for user #{user}"
          embed.colour = 'F04747'

          embed.description = error
        end
      else
        event.channel.send_embed do |embed|
          embed.title = "Mixer info for user #{name}"
          embed.url = "http://mixer.com/#{name}"
          embed.description = online.to_s

          embed.colour = if online == 'Currently Streaming!'
                           '43B581'
                         else
                           'FAA61A'
                         end

          embed.thumbnail = { url: avatar.to_s }

          embed.add_field(name: 'Followers', value: followers.to_s, inline: true)
          embed.add_field(name: 'Stream Title', value: (parse['name']).to_s, inline: true)
          embed.add_field(name: 'Total Views', value: (parse['viewersTotal']).to_s, inline: true)
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appreciate ya."
    end
  end
end
