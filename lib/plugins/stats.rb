module Stats
  extend Discordrb::Commands::CommandContainer

  command :stats do |event|
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

    event.channel.send_embed do |e|
      e.title = 'Chewbotcca - A basic, yet functioning, discord bot'

      e.add_field(name: 'Author', value: "Chew#0001\n[116013677060161545]", inline: true)
      e.add_field(name: 'Code', value: '<http://github.com/Chewbotcca/Discord>', inline: true)
      e.add_field(name: 'Bot Version', value: botversion, inline: true) unless botversion == ''
      e.add_field(name: 'Library', value: 'discordrb 3.2.1', inline: true)
      e.add_field(name: 'Uptime', value: "#{days}#{hours}#{mins}#{secs}", inline: true)
      e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
      e.add_field(name: 'Total User Count', value: event.bot.users.count, inline: true)
      e.color = '00FF00'
    end
  end
end
