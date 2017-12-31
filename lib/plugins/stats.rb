module Stats
  extend Discordrb::Commands::CommandContainer

  command :stats do |event|
    t = Time.now - starttime
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    event << 'Chewbotcca - A basic, yet functioning, discord bot.'
    event << 'Author: Chew#6216 [116013677060161545]'
    event << 'Code: <http://github.com/Chewsterchew/Chewbotcca>'
    event << 'Bot Version: beta 1.2.2'
    event << 'Library: discordrb 3.2.1'
    event << "Server Count: #{event.bot.servers.count}"
    event << "Total User Count: #{event.bot.users.count}"
    event << format('Uptime: %d days, %d hours, %d minutes and %d seconds', dd, hh, mm, ss)
  end
end
