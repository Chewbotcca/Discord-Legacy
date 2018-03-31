module About
  extend Discordrb::Commands::CommandContainer

  command(%i[help commands]) do |event|
    event.respond 'You can find all my commands here: <https://discord.chewbotcca.co/commands>. Invite me to your server or join my help server with `%^invite`'
  end

  command(:ping, min_args: 0, max_args: 1) do |event, noedit|
    if noedit == 'noedit'
      event.respond "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
    else
      m = event.respond('Pinging...')
      m.edit "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
    end
  end

  command(:invite) do |event|
    event.respond 'Hello! Invite me to your server here: <http://bit.ly/Chewbotcca>. Join my help server here: https://discord.gg/Q8TazNz'
  end

  command(:forceupdateservercount) do |event|
    next unless event.user.id == CONFIG['owner_id']
    event.bot.game = "on #{event.bot.servers.count} servers | %^help"
    RestClient.post("https://discordbots.org/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotsorg'], :'Content-Type' => :json) unless CONFIG['dbotsorg'].nil?
    RestClient.post("https://bots.discord.pw/api/bots/#{CONFIG['client_id']}/stats", '{"server_count":' + event.bot.servers.count.to_s + '}', :Authorization => CONFIG['dbotspw'], :'Content-Type' => :json)
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
                 elsif version.to_i > 0 && commits.zero?
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
        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
