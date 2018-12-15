module About
  extend Discordrb::Commands::CommandContainer

  command(%i[help commands about]) do |event|
    begin
      event.channel.send_embed do |embed|
        embed.title = 'Welcome to the Chewbotcca Discord Bot'
        embed.colour = 0xd084
        embed.description = 'Chewbotcca is a multi-purpose, semi-functional, almost always online, discord bot!'

        embed.add_field(name: 'Commands', value: 'You can find all my commands [here](http://discord.chewbotcca.co/commands)', inline: true)
        embed.add_field(name: 'Invite me!', value: 'You can invite me to your server with [this link](http://bit.ly/Chewbotcca).', inline: true)
        embed.add_field(name: 'Help Server', value: 'Click [me](https://discord.gg/Q8TazNz) to join the help server.', inline: true)
        embed.add_field(name: 'More Bot Stats', value: 'Run `%^stats` to see more stats!', inline: true)
      end
    rescue Discordrb::Errors::NoPermission
      event.respond 'Hello, in order for me to run most commands, I need the `Embed Links` permission, may you please grant that? Thanks, appreciate ya.'
    end
  end

  command(:ping, min_args: 0, max_args: 1) do |event, noedit|
    if noedit == 'noedit'
      event.respond "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
    else
      m = event.respond('Pinging...')
      m.edit "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
    end
  end

  command(:servers) do |event|
    servers = []
    counts = []
    Bots.each do |bot|
      servers.push "Shard \##{bot.shard_key[0]}: #{bot.servers.count} servers"
      counts.push bot.servers.count
    end
    servers.push ''
    servers.push "Total: #{counts.sum}"
    servers.push "Average: #{counts.average}"
    begin
      event.channel.send_embed do |e|
        e.title = 'Chewbotcca Server Stats!'

        e.description = servers.join("\n")
        e.color = '36399A'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond 'Hey woah I can\'t send embds.'
    end
  end

  command(:invite) do |event|
    event.respond 'Hello! Invite me to your server here: <http://bit.ly/Chewbotcca>. Join my help server here: https://discord.gg/Q8TazNz'
  end

  command(:forceupdateservercount) do |event|
    next unless event.user.id == CONFIG['owner_id']

    RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', Authorization: CONFIG['dbotspw'], 'Content-Type': :json)
    event.respond "You got it, bucko. I set the server count everywhere to `#{event.bot.servers.count}`"
  end

  command(:stats) do |event|
    t = Time.now - Starttime
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    days = format("%d days\n", dd) if dd != 0
    hours = format("%d hours\n", hh) if hh != 0
    mins = format("%d minutes\n", mm) if mm != 0
    secs = format('%d seconds', ss) if ss != 0

    commits = `git rev-list master | wc -l`.to_i
    version = `git describe --abbrev=0 --tags`.to_s

    botversion = if commits.zero? && version.zero?
                   ''
                 elsif version.to_i.positive? && commits.zero?
                   version
                 else
                   "#{version} (Commit: #{commits})"
                 end

    begin
      event.channel.send_embed do |e|
        e.title = 'Chewbotcca - A basic, yet functioning, discord bot'

        e.add_field(name: 'Author', value: '<@116013677060161545>', inline: true)
        e.add_field(name: 'Code', value: '[View code on GitHub](http://github.com/Chewbotcca/Discord)', inline: true)
        e.add_field(name: 'Bot Version', value: botversion, inline: true) unless botversion == ''
        e.add_field(name: 'Library', value: 'discordrb 3.2.1', inline: true)
        e.add_field(name: 'Uptime', value: "#{days}#{hours}#{mins}#{secs}", inline: true)
        e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
        e.add_field(name: 'Total User Count', value: event.bot.users.count, inline: true)
        e.color = 0xd084
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end

  command(:lib) do |event|
    gems = `gem list`.split("\n")
    libs = ['discordrb', 'rest-client', 'json', 'yaml', 'nokogiri']
    versions = []
    libs.each do |name|
      version = gems[gems.index { |s| s.include?(name) }].split(' ')[1]
      versions[versions.length] = version.delete('(').delete(',').delete(')')
    end
    begin
      event.channel.send_embed do |e|
        e.title = 'Chewbotcca - Open Source Libraries'

        (0..libs.length - 1).each do |i|
          url = "http://rubygems.org/gems/#{libs[i]}/versions/#{versions[i]}"
          e.add_field(name: libs[i], value: "[#{versions[i]}](#{url})", inline: true)
        end
        e.color = 0xd084
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
